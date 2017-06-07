require("pg")
require_relative("../db/sql_runner")
require_relative("artist")

class Album

  attr_accessor :name, :year, :artist_id, :genre
  attr_reader :id






  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name =  options["name"]
    @year = options["year"].to_i 
    @genre = options["genre"]
    @artist_id =  options["artist_id"]
  end







  def update() #working
    sql = "
    UPDATE albums SET (
      name,
      artist_id,
      year,
      genre
    ) = (
      '#{@name}',
      #{@artist_id},
      #{@year},
      '#{@genre}')
    WHERE id = #{@id}"
    result = SqlRunner.run(sql)
    return result
  end








  def save() #working
    sql = "INSERT INTO albums (name, year, artist_id, genre) 
      VALUES ('#{@name}', #{@year}, #{@artist_id}, '#{@genre}')
      RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"]
  end







  def artist() #working
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    result = SqlRunner.run(sql)
    artist_data = result[0]
    artist = Artist.new(artist_data)
    return artist
  end 







  def Album.all() #working
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map {|album| Album.new(album)}
  end







  def Album.delete_all() #working
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end








  def delete() #working
    sql = "DELETE FROM albums WHERE id = #{@id}"
    SqlRunner.run(sql)
  end








  def Album.find(id) #working
    sql = "SELECT * FROM albums WHERE id = #{id}"
    results = SqlRunner.run(sql)
    album_hash = results.first
    album = Album.new(album_hash)
    return album
  end








end