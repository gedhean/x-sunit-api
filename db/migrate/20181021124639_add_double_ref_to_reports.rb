class AddDoubleRefToReports < ActiveRecord::Migration[5.2]
  def change
  	reversible do |dir|
  		dir.up do
  			execute <<-SQL
  			PRAGMA foreign_keys=off;

  			BEGIN TRANSACTION;

  			ALTER TABLE reports RENAME reports_old; 

  			CREATE TABLE reports (
  				reporter_id integer, 
  				message text, 
  				abducted_id integer, 
  				created_at datetime NOT NULL, 
  				updated_at datetime NOT NULL, 
  				PRIMARY KEY (reporter_id, abducted_id),
  				CONSTRAINT fk_Survivors
  					FOREIGN KEY (reporter_id, abducted_id) 
  					REFERENCES survivors(id)
  			);
  			
  			INSERT INTO reports SELECT * FROM reports_old;

			COMMIT;
  			
  			PRAGMA foreign_keys=on;
  			SQL
  		end
  		dir.down do
  			execute <<-SQL
  			DROP TABLE IF EXISTS reports_old;
  			SQL
  		end
  	end
  end
end
