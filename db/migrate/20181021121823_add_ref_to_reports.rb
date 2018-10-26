class AddRefToReports < ActiveRecord::Migration[5.2]
  def change
  	add_foreign_key :reports, :survivors, column: :reporter_id, on_delete: :cascade, on_update: :cascade
  	add_foreign_key :reports, :survivors, column: :abducted_id, on_delete: :cascade, on_update: :cascade
  end
end
