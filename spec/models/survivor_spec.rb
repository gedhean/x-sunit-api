require 'rails_helper'

RSpec.describe Survivor, type: :model do

	# Ensure that theses attributes are present before saving
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:age) }
	it { should validate_presence_of(:gender) }
	it { should validate_presence_of(:longitude) }
	it { should validate_presence_of(:latitude) }
end