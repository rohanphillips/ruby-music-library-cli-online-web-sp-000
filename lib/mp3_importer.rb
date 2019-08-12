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

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    response = ""
    while response != "exit"
      response = gets.strip
    end
  end

  def list_songs
    Song.all.sort_by{|song| song.name}.each_with_index{|song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
  end

  def list_artists
    Artist.all.sort_by{|artists| artists.name}.uniq.each_with_index{|artist, index|
      puts "#{index + 1}. #{artist.name}"
    }
  end

  def list_genres
    Genre.all.sort_by{|genres| genres.name}.uniq.each_with_index{|genre, index|
      puts "#{index + 1}. #{genre.name}"
    }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets.strip
    Song.all.sort_by{|song| song.name}.each_with_index{|song, index| 
      if song.artist.name == name
        puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    }
  end
end
