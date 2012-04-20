class ChangeColumnToeflResults < ActiveRecord::Migration
  def change
    change_column :admission_informations, :toefl_test_results, :float
  end
end
