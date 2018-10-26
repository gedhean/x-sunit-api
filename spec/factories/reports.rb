FactoryBot.define do
	factory :report do
		reporter_id { Survivor.select(:id).sample.id }
		message { Faker::Lorem.sentence }
		# Range index of abduced survivor need to be short
		# To ensure that will be reported only survivors that exist
		abducted_id { Survivor.select(:id).sample.id }
	end
end