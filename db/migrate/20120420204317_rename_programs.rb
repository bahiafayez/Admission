class RenamePrograms < ActiveRecord::Migration
    def change
        rename_table :programs, :schools
    end 
end
