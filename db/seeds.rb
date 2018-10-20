# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do 
	Survivor.create({
		name: Faker::Name.name,
		age: Faker::Number.between(2, 100),
		gender: Faker::Gender.binary_type,
		latitude: Faker::Number.decimal(5),
		longitude: Faker::Number.decimal(5)
	})	
end