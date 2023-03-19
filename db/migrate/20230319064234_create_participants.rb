class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.references :project, type: :uuid, null: false, foreign_key: true
      t.uuid :employee_id

      t.timestamps
    end
  end
end
