class AddNotesToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :notes, :text
  end
end
