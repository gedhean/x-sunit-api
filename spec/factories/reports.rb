FactoryBot.define do
	factory :report do
		reporter_id { Faker::Number.between(1, 30) }
		message { Faker::Lorem.sentence }
		abducted_id { Faker::Number.between(1, 10) }
	end
end