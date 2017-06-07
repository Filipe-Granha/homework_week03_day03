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


  def update()
    sql = "
    UPDATE pizza_orders SET (
      name,
      artist_id,
      year,
      genre
    ) = (
      '#{@name}',
      #{@artist_id},
      #{@year},
      '#{@genre}'
    WHERE id = #{@id}"
    result = SqlRunner.run(sql)
    return result
  end










  def save()
    sql = "INSERT INTO albums (name, year, artist_id, genre) 
      VALUES ('#{@name}', #{@year}, #{@artist_id}, '#{@genre}')
      RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"]
  end



  def artist()
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    result = SqlRunner.run(sql)
    artist_data = result[0]
    artist = Artist.new(artist_data)

    return artist
  end 



  def Album.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map {|album| Album.new(album)}
  end



  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end










end