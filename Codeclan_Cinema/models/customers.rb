require('pg')
require_relative('./films.rb')
require_relative('./tickets.rb')
require_relative('./customers.rb')
require_relative('../db/sql_runner.rb')

class Customers

  attr_reader :id
  attr_accessor :name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds'].to_i
end

def save()
  sql = "INSERT INTO customers(
  name, funds
  ) VALUES ($1, $2)
  RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    # customer_hash = customer[0]
    # id_string = customer_hash['id']
    @id = customer['id'].to_i
end

def update()
  sql = "UPDATE customers SET
  (
    name
    ) = (
      $1
      )
      WHERE id = $1"
      values = [@name, @id]
      SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM customers
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM customers"
  values = []
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM customers"
  values = []
  customer = SqlRunner.run(sql, values)
  result = customers.map { |customer| Customers.new(customer)}
  return result
end

def films()
  sql = "SELECT films.* FROM films
  INNER JOIN tickets ON
  tickets.film_id = films.id
  WHERE customer_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  result = films.map { |film| Films.new(film)}
  return result
end



# def films()
#   sql = "SELECT films.* FROM films
#   INNER JOIN tickets ON
#   tickets.film_id = films.id
#   WHERE customer_id = $1"
#   values = [@id]
#     films = SqlRunner.run(sql, values)
#     result = films.map { |film| Films.new(film)}
#     return result
# end

def self.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new(customer)}
  return result
end

# def funds_less_ticket()
#   funds =
#
# end


end
