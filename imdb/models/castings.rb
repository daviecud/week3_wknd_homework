require_relative('../db/sql_runner')

class Casting

  attr_reader :id
  attr_accessor :star_id, :movie_id

def initialize(options)
  @id = options['id'].to_i if options ['id']
  @star_id = options['star_id'].to_i
  @movie_id = options['movie_id'].to_i
end

def save()
  sql = "INSERT INTO castings(
    star_id,
    movie_id
  ) VALUES (
    $1, $2
    ) RETURNING id"
    values = [@star_id, @movie_id]
    cast = SqlRunner.run(sql, values).first
    @id = cast['id'].to_i
end

def self.all()
  sql = "SELECT * FROM castings"
  casting = SqlRunner.run(sql)
  result = casting.map { |cast| Casting.new(cast)}
  return result
end

def self.delete_all()
  sql = "DELETE FROM castings"
  SqlRunner.run(sql)
end

def delete()
  sql = "DELETE FROM castings
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE castings
  SET (star_id, movie_id) = ($1, $2)
  WHERE id id = $3"
  values = [@star_id, @movie_id, @id]
  SqlRunner.run(sql, values)
end

def movie()
  sql = "SELECT * FROM movies
  WHERE id = $1"
  values = [@movie_id]
  movie = SqlRunner.run(sql, values).first
  return Movie.new(movie)
end

def star()
  sql = "SELECT * FROM stars
  WHERE id = $1"
  values = [@star_id]
  star = SqlRunner.run(sql, values).first
  return Star.new(star)
end


end
