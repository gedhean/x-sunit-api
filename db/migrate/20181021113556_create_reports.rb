class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table(:reports) do |t|
      t.integer :reporter_id
      t.integer :abducted_id
      t.text :message

      t.timestamps
    end
  end
end
