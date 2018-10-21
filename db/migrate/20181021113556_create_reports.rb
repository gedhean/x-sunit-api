class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table(:reports, primary_key: [:reporter_id, :abducted_id]) do |t|
      t.integer :reporter_id
      t.text :message
      t.integer :abducted_id

      t.timestamps
    end
  end
end
