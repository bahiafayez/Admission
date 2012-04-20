class RenameColumnSemesters < ActiveRecord::Migration
   def change
    rename_column :admission_informations, :program_id, :school_id
  end

end
