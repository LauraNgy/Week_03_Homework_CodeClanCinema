class Film

  attr_reader :id
  attr_accessor :title, :price

    def initialize(options)
      @title = options['title']
      @price = options['price'].to_i
      @id = options['id'].to_i if options['id']
    end

    def save()
      sql = "
        INSERT INTO films
        (title, price)
        VALUES
        ($1, $2)
        RETURNING *
      "
      values = [@title, @price]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = "
        UPDATE
          films
        SET
          (title, price) = ($1, $2)
        WHERE
          id = $3
        "
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "
        DELETE FROM
          films
        WHERE
          id = $1
        "
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def customers()
      sql = "
        SELECT customers.* FROM
          customers
        INNER JOIN
          tickets
        ON
          tickets.customer_id = customers.id
        INNER JOIN
          screenings
        ON
          tickets.screening_id = screenings.id
        WHERE
          screenings.film_id = $1
      "
      values = [@id]
      customers = SqlRunner.run(sql, values)
      result = Customer.map_items(customers)
      return result
    end

    def Film.all()
      sql = "SELECT * FROM films"
      films = SqlRunner.run(sql)
      return self.map_items(films)
    end

    def self.map_items(film_data)
      result = film_data.map { |film| Film.new(film) }
      return result
    end

    def Film.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

end
