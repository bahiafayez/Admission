class ChangeColumnGpaInCollege < ActiveRecord::Migration
  def up
    change_column :colleges, :gpa, :float , :default => 0
  end

  def down
    change_column :colleges, :gpa, :float, :default => nil
  end
end
