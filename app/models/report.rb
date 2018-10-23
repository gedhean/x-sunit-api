class Report < ApplicationRecord
	validates 	:reporter_id, :abducted_id, :message, presence: true
	validates 	:reporter_id, :abducted_id, numericality: { only_integer: true }
	after_save 	:update_flag_abducted_in_survivors

	private
	# Flag the survivor as abducted if there is at least three reports for that survivor
	def update_flag_abducted_in_survivors
		num_reports =  Report.where(abducted_id: abducted_id).count
		if num_reports >= 3
			Survivor.update(abducted_id, abducted: true)
		end 
	end
end
