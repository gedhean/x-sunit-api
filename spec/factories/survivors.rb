FactoryBot.define do
	factory :survivor do
		name { Faker::Name.name }
		age { Faker::Number.between(2, 100) }
		gender { Faker::Gender.binary_type }
		latitude { Faker::Number.decimal(5) }
		longitude { Faker::Number.decimal(5) }
		abducted { false }
	end
end