class Ticket

  attr_reader :id
  attr_accessor :customer_id, :screening_id

    def initialize(options)
      @customer_id = options['customer_id'].to_i
      @screening_id = options['screening_id'].to_i
      @id = options['id'].to_i if options['id']
    end

    def save()
      sql = "
        INSERT INTO tickets
        (customer_id, screening_id)
        VALUES
        ($1, $2)
        RETURNING *
      "
      values = [@customer_id, @screening_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def update()
      sql = "
        UPDATE
          tickets
        SET
          (customer_id, screening_id) = ($1, $2)
        WHERE
          id = $3
        "
      values = [@customer_id, @screening_id, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "
        DELETE FROM
          tickets
        WHERE
          id = $1
        "
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def Ticket.all()
      sql = "SELECT * FROM tickets"
      tickets = SqlRunner.run(sql)
      return self.map_items(tickets)
    end

    def self.map_items(ticket_data)
      result = ticket_data.map { |ticket| Ticket.new(ticket) }
      return result
    end

    def Ticket.delete_all()
      sql = "DELETE FROM tickets"
      SqlRunner.run(sql)
    end




end
