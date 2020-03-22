class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist #artist_id
  belongs_to :genre #genre_id
  has_many :notes
  accepts_nested_attributes_for :notes, reject_if: proc { |attrs| attrs[:content].blank? }

  # overriding the creation of a Song object using the artist_id
  # in favor of the artist_name
  # def artist_name=(name)
  #   #the instance of song is assigning it's artist object using
  #   # Artist's name attribute and not id 
  #   self.artist = Artist.find_or_create_by(name: name)
  # end
  def artist_name=(name)
    # @artist_name = name
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    # artist == artist_id == artist object
    self.artist ? self.artist.name : nil
    # or
    artist.try(:name)
  end

  # def genre_name=(name)
  #   self.genre = Genre.find_or_create_by(name: name)
  # end

  # def genre_name
  #   self.genre ? self.genre.name : nil 
  # end

  # song has many notes
  def notes_content=(content)
    content.each do |note_content|
      note = Note.find_or_create_by(content: note_content)
      self.notes << note
    end
  end
  
end
