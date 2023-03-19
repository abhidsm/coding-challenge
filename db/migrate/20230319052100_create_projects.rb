class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.uuid :owner_id
      t.integer :state
      t.float :progress

      t.timestamps
    end
  end
end
