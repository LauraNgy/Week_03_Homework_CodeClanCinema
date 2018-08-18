class Customer

  attr_reader :id
  attr_accessor :name, :funds

    def initialize(options)
      @name = options['name']
      @funds = options['funds'].to_i
      @id = options['id'].to_i if options['id']
    end

    def save()
      sql = "
        INSERT INTO customers
        (name, funds)
        VALUES
        ($1, $2)
        RETURNING *
      "
      values = [@name, @funds]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = "
        UPDATE
          customers
        SET
          (name, funds) = ($1, $2)
        WHERE
          id = $3
        "
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "
        DELETE FROM
          customers
        WHERE
          id = $1
        "
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def films()
      sql = "
        SELECT films.* FROM
          films
        INNER JOIN
          screenings
        ON
          screenings.film_id = films.id
        INNER JOIN
          tickets
        ON
          tickets.screening_id = screenings.id
        INNER JOIN
          customers
        ON
          tickets.customer_id = $1
      "
      values = [@id]
      films = SqlRunner.run(sql, values)
      result = Film.map_items(films)
      return result
    end

    def Customer.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      return self.map_items(customers)
    end

    def self.map_items(customer_data)
      result = customer_data.map { |customer| Customer.new(customer) }
      return result
    end

    def Customer.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end




end
