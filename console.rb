require('pry-byebug')
require_relative('db/sqlrunner')
require_relative('models/customer')
require_relative('models/film')

customer = Customer.new({
  'name' => 'George',
  'funds' => 100
  })

customer.save()

film = Film.new({
  'title' => 'Foob Life',
  'price' => 10
  })

film.save()

binding.pry
nil
