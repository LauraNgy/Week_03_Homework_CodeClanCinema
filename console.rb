require('pry-byebug')
require_relative('models/customer')
require_relative('db/sqlrunner')

customer = Customer.new({
  'name' => 'George',
  'funds' => 100
  })

customer.save()

binding.pry
nil
