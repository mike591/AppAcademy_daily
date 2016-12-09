class AlbumsController < ApplicationController
  def new
    render :new
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to band_url(album.band_id)
    else
      flash[:message] = "Unable to create album"
      redirect_to new_album_url
    end
  end


  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash[:message] = "Unable to update album"
      redirect_to edit_album_url(@album)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      redirect_to band_url(@album.band_id)
    else
      flash[:message] = "Failed to delete"
      redirect_to album_url(@album)
    end
  end

  private
  def album_params
    params.require(:album).permit(:name, :album_type, :band_id)
  end

end
