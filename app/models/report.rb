class Report < ApplicationRecord
	validates 	:reporter_id, :abducted_id, :message, presence: true
	validates 	:reporter_id, :abducted_id, numericality: { only_integer: true }
	before_save :update_flag_abducted_in_survivors

	private
	# Flag the survivor as abducted if there is at least three reports for that survivor
	def update_flag_abducted_in_survivors
		# Raise a NotFount error if survivor not exist
		@survivor = Survivor.find(abducted_id)
		num_reports =  Report.where(abducted_id: abducted_id).count
		if num_reports >= 3
			@survivor.update(abducted: true)
		end 
	end
end
