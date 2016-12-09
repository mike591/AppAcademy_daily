class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:message] = "Unable to save"
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash[:message] = "Invalid updates"
      redirect_to edit_band_url(@band)
    end
  end

  def destroy
      @band = Band.find(params[:id])
      if @band.destroy
        redirect_to bands_url
      else
        flash[:message] = "Failed to delete"
        redirect_to band_url(@band)
      end
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end
