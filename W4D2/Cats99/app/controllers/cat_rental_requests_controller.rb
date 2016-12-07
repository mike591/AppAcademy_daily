class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    render :new
  end

  def create
    @rental = CatRentalRequest.new(cat_rental_request_params)
    if @rental.save
      redirect_to cat_url(@rental.cat_id)
    else
      render json: @rental.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @rental = CatRentalRequest.find(params[:id])
    if @rental.approve!
      redirect_to cat_url(@rental.cat_id)
    else
      render json: @rental.errors.full_messages, status: :unprocessable_entity
    end
  end


  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
