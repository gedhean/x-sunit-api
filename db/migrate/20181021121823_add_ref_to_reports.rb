class AddRefToReports < ActiveRecord::Migration[5.2]
  def change
  	add_foreign_key :reports, :survivors, column: [:reporter_id, :abducted_id]
  end
end
