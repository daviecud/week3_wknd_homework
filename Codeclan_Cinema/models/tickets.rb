require('pg')
require_relative('./films.rb')
require_relative('./tickets.rb')
require_relative('./customers.rb')
require_relative('../db/sql_runner.rb')

class Tickets

  attr_reader :id
  attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets(
  customer_id,
  film_id
  ) VALUES (
    $1, $2
    ) RETURNING id"
    values = [@cutomer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
end

def customer()
  sql ="SELECT * FROM customers WHERE id = $1"
  values = [@customer_id]
  customer = SqlRunner.run(sql, values).first
  return Customers.new(customer)
end

def film()
  sql = "SELECT * FROM films WHERE id = $1"
  values = [@film_id]
  film = SqlRunner.run(sql, values).first
  return Films.new(film)
end

def self.all()
  sql = "SELECT * FROM tickets"
  tickets_data = SqlRunner.run(sql)
  return Tickets.new(tickets_data)
end

def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def update()
  sql = "UPDATE tickets SET (
    customer_id, film_id
  ) = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def self.map_items(tickets)
  result = tickets.map { |tickets| Tickets.new(tickets)}
  return result
end




end
