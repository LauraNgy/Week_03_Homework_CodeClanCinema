require('pry-byebug')
require_relative('db/sqlrunner')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')
require_relative('models/ticket')

Customer.delete_all()
Film.delete_all()
Screening.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'George',
  'funds' => 100
  })
customer2 = Customer.new({
  'name' => 'James',
  'funds' => 200
  })
customer3 = Customer.new({
  'name' => 'Fred',
  'funds' => 150
  })

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({
  'title' => 'Foob Life',
  'price' => 5
  })
film2 = Film.new({
  'title' => 'The Foob Sisters',
  'price' => 10
  })

film1.save()
film2.save()

screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '18:00',
  'capacity' => 20
  })
screening2 = Screening.new({
  'film_id' => film2.id,
  'screening_time' => '20:00',
  'capacity' => 15
  })
screening3 = Screening.new({
  'film_id' => film2.id,
  'screening_time' => '22:00',
  'capacity' => 2
  })

screening1.save()
screening2.save()
screening3.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening1.id
  })
ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening2.id
  })
ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening3.id
  })
ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening3.id
  })
ticket5 = Ticket.new({
  'customer_id' => customer3.id,
  'screening_id' => screening3.id
  })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()

binding.pry
nil
