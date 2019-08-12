require 'pry'
require_relative '../lib/concerns/memorable'
require_relative '../lib/concerns/findable'
require_relative '../lib/concerns/paramable'

class Genre
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods
  extend Findable::ClassMethods
  include Paramable::InstanceMethods

  attr_accessor :name
  attr_reader :genres

  @@all = []

  def initialize(name)
    @name = name
    self.class.all << self
    @genres = []
    @songs = []
  end

  def self.create(genre)
    newgenre = Genre.new(genre)
    newgenre.save
    newgenre
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end
end
