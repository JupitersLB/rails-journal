class AddDateToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :date, :datetime
  end
end
