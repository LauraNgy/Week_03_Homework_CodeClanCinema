class Screening

    attr_reader :id
    attr_accessor :film_id, :screening_time, :capacity

      def initialize(options)
        @film_id = options['film_id'].to_i
        @screening_time = options['screening_time']
        @capacity = options['capacity'].to_i
        @id = options['id'].to_i if options['id']
      end

      def save()
        sql = "
          INSERT INTO screenings
          (film_id, screening_time, capacity)
          VALUES
          ($1, $2, $3)
          RETURNING *
        "
        values = [@film_id, @screening_time, @capacity]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
      end

      def update()
        sql = "
          UPDATE
            screenings
          SET
            (film_id, screening_time, capacity) = ($1, $2, $3)
          WHERE
            id = $4
          "
        values = [@film_id, @screening_time, @capacity, @id]
        SqlRunner.run(sql, values)
      end

      def delete()
        sql = "
          DELETE FROM
            screenings
          WHERE
            id = $1
          "
        values = [@id]
        SqlRunner.run(sql, values)
      end


      def Screening.all()
        sql = "SELECT * FROM screenings"
        screenings = SqlRunner.run(sql)
        return self.map_items(screenings)
      end

      def self.map_items(screening_data)
        result = screening_data.map { |screening| Screening.new(screening) }
        return result
      end

      def Screening.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
      end

end
