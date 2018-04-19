class RemoveEmailFromInstructor < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructors, :email
  end
end
