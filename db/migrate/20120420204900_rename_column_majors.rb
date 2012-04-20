class RenameColumnMajors < ActiveRecord::Migration
   def change
    rename_column :majors, :program_id, :school_id
  end

end
