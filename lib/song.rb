require 'pry'
require_relative '../lib/concerns/memorable'
require_relative '../lib/concerns/findable'
require_relative '../lib/concerns/paramable'
require_relative '../config/environment'

class Song
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods
  extend Findable::ClassMethods
  include Findable::InstanceMethods
  include Paramable::InstanceMethods
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []


  def initialize(name, artist = "", genre = "")
    @name = name
    @@artist = artist
    self.artist=(artist)
    self.genre=(genre)
  end

  def self.create(name)
    newsong = Song.new(name)
    newsong.save
    newsong
  end

  def self.new_from_filename(name)

    info = name.match(/\w*.*(?=[.])/).to_s
    songname = Song.get_info(info, "songname")
    newsong = self.create(songname)
    artistname = Song.get_info(info, "artist")
    newartist = self.find_by_name(artistname)
    if newartist == nil
      newartist = Artist.create(artistname)
    end
    newsong.artist = newartist

    newsong.genre = Genre.create(Song.get_info(info, "genre"))

    newsong
  end

  def self.get_info(info, infotype)
    collection = info.split(" - ")
    case infotype
      when "artist"
        return collection[0].to_s
      when "songname"
        return collection[1].to_s
      when "genre"
        return collection[2].to_s
    end
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist
    if artist != ""
      artist.add_song(self)
    end
  end

  def genre=(genre)
    @genre = genre
    if genre != ""
      genre.add_song(self)
    end
  end



end
