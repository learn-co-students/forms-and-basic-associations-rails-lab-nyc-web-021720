class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  accepts_nested_attributes_for :notes #, :reject_if => proc { |attrs| attrs[:content].blank? }

  def artist_name=(name)
    art = Artist.find_or_create_by(name: name)
    art.songs << self
  end

  def artist_name
    artist ? artist.name : nil
  end

  def genre_name=(name)
    gen = Genre.find_or_create_by(name: name)
    gen.songs << self
  end

  def genre_name
    genre ? genre.name : nil
  end
end
