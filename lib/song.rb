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
    self.create(name)
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
