class RemovePhone < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructors, :phone
  end
end
