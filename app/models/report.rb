class Report < ApplicationRecord
	validates :reporter_id, :abducted_id, presence: true

	after_save :update_falg_abducted_in_survivors

	private
	def update_falg_abducted_in_survivors
		num_reports =  Report.where(abducted_id: abducted_id).count
		unless num_reports < 3
			Survivor.update(abducted_id, abducted: true)
		end 
	end
end
