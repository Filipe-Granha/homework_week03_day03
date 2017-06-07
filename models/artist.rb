require('pg')
require('pry')
require_relative('album')
require_relative('../db/sql_runner')


class Artist


  attr_reader :name, :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end


  def update()
    sql = "
    UPDATE pizza_orders SET (
      name
    ) = (
      '#{@name}'
    WHERE id = #{@id}"
    result = SqlRunner.run(sql)
    return result
  end


  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id"
    @id = SqlRunner.run(sql)[0]["id"]
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    result = SqlRunner.run(sql)
    albums = result.map() {|album| Album.new(album)}
    return albums
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end



  def Artist.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end






  end

