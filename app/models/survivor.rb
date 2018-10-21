class Survivor < ApplicationRecord
	validates :name, :age, :gender, :latitude, :longitude, presence: true
	validates :name, length: { minimum: 4 }
	validates :age, numericality: { only_integer: true }
	validates :latitude, :longitude, numericality: true
	validates :abducted, inclusion: { in: [true, false] }
	validates :abducted, exclusion: { in: [nil]}
end
