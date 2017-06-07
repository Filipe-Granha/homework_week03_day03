require('pg')
require('pry')
require_relative('album')
require_relative('../db/sql_runner')


class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end


  def update() #first step: artist_1.name="Queen"; second step: artist_1.update - working
    sql = "
    UPDATE artists SET (
      name
    ) = (
      '#{@name}')
    WHERE id = #{@id}"
    result = SqlRunner.run(sql)
    return result
  end





  def save() #working in console
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id"
    @id = SqlRunner.run(sql)[0]["id"].to_i
  end





  def albums() #working
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    result = SqlRunner.run(sql)
    albums = result.map() {|album| Album.new(album)}
    return albums
  end






  def Artist.all() #working
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end




  def delete() #only works if there's no connection to the class Album? "update or delete on table "artists" violates foreign key", would then have to hide the .albums method on this file, just above.
    sql = "DELETE FROM artists WHERE id = #{@id}"
    SqlRunner.run(sql)
  end






  def Artist.delete_all() #working in console
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end







  def Artist.find(id) #working
    sql = "SELECT * FROM artists WHERE id = #{id}"
    results = SqlRunner.run(sql)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist
  end




  end

