class ChangeColumnWorkTasks < ActiveRecord::Migration
  def up
    change_column :works, :tasks, :text
  end

  def down
    change_column :works, :tasks, :string
  end
end
