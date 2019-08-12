require "pry"
class MusicImporter
  attr_accessor :path, :files
  def initialize(path)
    @path = path
    tempfiles = Dir["#{path}/*.mp3"]
    @files = tempfiles.collect{|n| n.slice(n.rindex("/") + 1, n.size)}
  end

  def import
    collection = @files.collect{|n| n.match(/\w*.*(?=[.])/)}
    @files.each do |i|
      Song.create_from_filename(i)
    end

  end

end
