require 'pry'
require_relative '../lib/concerns/memorable'
require_relative '../lib/concerns/findable'
require_relative '../lib/concerns/paramable'

class Song
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods
  extend Findable::ClassMethods
  include Paramable::InstanceMethods

  attr_accessor :name
  attr_reader :artist

  @@all = []


  def initialize(name, artist = "")
    @name = name
    @@artist = artist
    artist=(artist)
    # if artist != ""
    #   self.artist=(artist)
    # end
  end

  def self.create(name)
    newsong = Song.new(name)
    newsong.save
    newsong
  end


  def self.all
    @@all
  end

  def artist=(artist)
    binding.pry
    @artist = artist
    artist.add_song(self)
  end


end
