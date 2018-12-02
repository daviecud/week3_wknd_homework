require('pg')
require_relative('./films.rb')
require_relative('./tickets.rb')
require_relative('./customers.rb')

# require_relative('../db/cinema.sql')
require_relative('../db/sql_runner.rb')


class Films

attr_reader :id
attr_accessor :title, :price

def initialize(options)
  @id = options['id'].toi if options['id']
  @title = options['title']
  @price = options['price'].to_i
end

def save()
  sql = "INSERT INTO films (
  title, price
  ) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
end

def customer()
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  WHERE film_id = $1"
  values = [@id]
  customer = SqlRunner.run(sql, values)
    result = customer.map { |cust| Customers.new(cust)}
  return result
end

def self.all()
  sql = "SELECT * FROM tickets"
  values = []
  films = SqlRunner.run(sql, values)
  result = films.map { |film| Films.new(film)}
end

def self.delete_all()
  sql = "DELETE FROM films"
  values = []
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE films SET (
    title, price
  ) = ($1, $2) WHERE id = $3"
  values = [@first_name, @last_name, @id]
  SqlRunner.run(sql, values)
end

def self.map(film_data)
  result = film_data.map { |film| Films.new(films)}
  return result
end


end
