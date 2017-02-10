# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Product.create( title: Faker::Pokemon.name,
                  description: Faker::Pokemon.location,
                  price: Faker::Number.decimal(2) )
  User.create( first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
               email: Faker::Internet.email )
end

puts '10 products created! & 10 users too!'

30.times do
  Product.create( title: Faker::Color.color_name + ' computer',
                  description: Faker::Lorem.sentence,
                  price: Faker::Number.decimal(2) )
end

puts '30 computers!'
