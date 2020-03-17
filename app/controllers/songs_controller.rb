class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new

    3.times {@song.notes.build}
  end

  def create
    @song = Song.create(song_params)
    if @song.valid?
    redirect_to song_path(@song)
    else 
      flash[:error] = "This song already exists"
      #flash[:errors] = @song.errors.full_messages
      redirect_to new_song_path
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, notes_attributes: [:content])
  end
end

