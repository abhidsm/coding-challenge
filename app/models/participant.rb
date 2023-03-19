class Participant < ApplicationRecord
  belongs_to :project

  validates_presence_of :project_id, :employee_id
end
