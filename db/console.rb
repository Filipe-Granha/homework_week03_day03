require('pg')
require('pry-byebug')
require_relative("../models/album")
require_relative("../models/artist")


Album.delete_all()
Artist.delete_all()




artist_1 = Artist.new({
  "name" => "Incubus"
  })
artist_2 = Artist.new({
  "name" => "Smash mouth"
  })

artist_1.save()
artist_2.save()

album_1 = Album.new({
  "name" => "Drive",
  "year" => 2000,
  "genre" => "Rock",
  "artist_id" => artist_1.id
  })
album_2 = Album.new({
  "name" => "All Star",
  "year" => 1995,
  "genre" => "Pop",
  "artist_id" => artist_2.id
  })
album_3 = Album.new({
  "name" => "The Album",
  "year" => 2005,
  "genre" => "HipHop",
  "artist_id" => artist_1.id
  })

album_1.save()
album_2.save()
album_3.save()




binding.pry
nil