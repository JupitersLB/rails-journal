class RemoveSecondNameFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :second_name, :string
  end
end
