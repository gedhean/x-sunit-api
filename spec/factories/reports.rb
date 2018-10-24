FactoryBot.define do
	factory :report do
		reporter_id { Faker::Number.between(1, 30) }
		message { Faker::Lorem.sentence }
		# Range index of abduced survivor need to be short
		# To ensure that will be reported only survivors that exist
		abducted_id { Faker::Number.between(1, 5) }
	end
end