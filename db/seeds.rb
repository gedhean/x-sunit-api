# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Report.delete_all
Survivor.delete_all

100.times do 
	Survivor.create({
		name: Faker::Name.name,
		age: Faker::Number.between(2, 100),
		gender: Faker::Gender.binary_type,
		latitude: Faker::Number.decimal(5),
		longitude: Faker::Number.decimal(5)
	})	
end

40.times do
	rp_id = Survivor.select(:id).sample
	sv_id = Survivor.select(:id).sample
	Report.create({
		reporter_id: rp_id,
		message: Faker::Lorem.sentence,
		reporter_id: sv_id,
	})
end
