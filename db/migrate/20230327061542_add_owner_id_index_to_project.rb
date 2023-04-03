class AddOwnerIdIndexToProject < ActiveRecord::Migration[7.0]
  def change
    add_index :projects, :owner_id
  end
end
