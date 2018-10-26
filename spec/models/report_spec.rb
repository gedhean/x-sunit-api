require 'rails_helper'

RSpec.describe Report, type: :model do
	# Ensure that theses attributes are present before saving
	it { should validate_presence_of(:reporter_id) }
	it { should validate_presence_of(:message) }
	it { should validate_presence_of(:abducted_id) }

	let!(:survivors) { create_list(:survivor, 10) }
	let(:survivor_id) { survivors.first.id }

	describe 'lifecycle callback before_save' do
		let(:report) { build(:report, abducted_id: survivor_id, reporter_id: survivor_id) }

		it 'trigger update_flag_abducted_in_survivors' do
			expect(report).to receive(:update_flag_abducted_in_survivors)
			report.save!
		end
	end

	describe 'update_flag_abducted_in_survivors' do
		

		context 'when there less then three or more reports' do
			it 'do NOT falg survivor as `abducted`' do
				# I know that it's not the best solution, but for now works
				@survivor = Survivor.find(survivor_id)
				@num_reports = Report.where("abducted_id = #{survivor_id}").count 
				
				expect(@num_reports).to be < 3
				expect(@survivor.abducted).to eq(false)
			end
		end

		context 'when there more then three reports' do
			# Ensure that there are more then or three reports to the same survivor
			before { 4.times { create(:report, abducted_id: survivor_id) } }
			it 'flag survivor as `abducted` (true)' do
				# I know that it's not the best solution, but for now works
				@survivor = Survivor.find(survivor_id)
				@num_reports = Report.where("abducted_id = #{survivor_id}").count 

				expect(@num_reports).to be >= 3
				expect(@survivor.abducted).to eq(true)
			end
		end

		context 'when abducted_id does not exist in Survivors' do
			it 'raise a NotFound error' do
			 	expect { create(:report, abducted_id: 666) }.to raise_error(ActiveRecord::RecordNotFound)
			end
		end
	end
end