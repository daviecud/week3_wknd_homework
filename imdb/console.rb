require_relative('./models/castings.rb')
require_relative('./models/movies.rb')
require_relative('./models/stars.rb')

require('pry')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({ 'first_name' => 'Samuel L', 'last_name' => 'Jackson'})
star1.save()
star2 = Star.new({ 'first_name' => 'Bruce', 'last_name' => 'Willis'})
star2.save()
star3 = Star.new({ 'first_name' => 'John', 'last_name' => 'Travolta'})
star3.save()
star4 = Star.new({ 'first_name'=> 'Tim', 'last_name' => 'Roth'})
star4.save()


movie1 = Movie.new({ 'title' => 'Pulp Fiction', 'genre' => 'Action'})
movie2 = Movie.new({ 'title' => 'The Hateful 8', 'genre' => 'Western'})
movie3 = Movie.new({ 'title' => 'Reservoir Dogs', 'genre' => 'Action'})
movie1.save()
movie2.save()
movie3.save()

casting1 = Casting.new({ 'star_id' => star2.id, 'movie_id' => movie1.id })
casting2 = Casting.new({ 'star_id' => star4.id, 'movie_id' => movie3.id })
casting3 = Casting.new({ 'star_id' => star1.id, 'movie_id' => movie2.id })
casting4 = Casting.new({ 'star_id' => star4.id, 'movie_id' => movie2.id })
casting5 = Casting.new({ 'star_id' => star1.id, 'movie_id' => movie1.id })
casting1.save()
casting2.save()
casting3.save()
casting4.save()
casting5.save()


binding.pry
nil
