class ChangeAbductedDefaultValue < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :survivors, :abducted, false
  end
end
