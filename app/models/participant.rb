class Participant < ApplicationRecord
  belongs_to :project

  validates_presence_of :project_id, :employee_id
  validate :participant_must_be_from_same_department

  def participant_must_be_from_same_department
    if project && employee_id && Employee.by_id(employee_id)&.department != Employee.by_id(project.owner_id)&.department
      errors.add(:employee_id, "is not from same department")
    end
  end
end
