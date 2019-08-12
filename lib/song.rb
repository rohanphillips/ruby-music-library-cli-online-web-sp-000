require 'pry'
require_relative '../lib/concerns/memorable'
require_relative '../lib/concerns/findable'
require_relative '../lib/concerns/paramable'

class Song
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods
  extend Findable::ClassMethods
  include Findable::InstanceMethods
  include Paramable::InstanceMethods

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

  def self.find_or_create_by_name(name)
    newsong = self.find_by_name(name)
    if newsong.name != name
      newsong = Song.new(name)
    end
    newsong
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
