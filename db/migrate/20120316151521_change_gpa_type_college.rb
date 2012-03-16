class ChangeGpaTypeCollege < ActiveRecord::Migration
  def up
    change_column :colleges, :gpa, :string, :default => ""
  end
  def down
    change_column :colleges, :gpa, :float
  end
end
