class TracksController < ApplicationController
  def new
    render :new
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash[:message] = "unable to save track"
      redirect_to new_track_url
    end
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash[:message] = "Unable to delete track"
      redirect_to edit_track(@track)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track.destroy
      redirect_to album_url(@track.album_id)
    else
      flash[:message] = "Unable to delete track"
      redirect_to track_url(@track)
    end
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end

end
