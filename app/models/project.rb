class Project < ApplicationRecord
  OWNER_ROLE = Rails.configuration.settings.project_owner_role
  enum :state, { planned: 0, active: 1, done: 2, failed: 3 }, suffix: true

  validates_presence_of :name, :owner_id, :state
  validates :state, inclusion: { in: states.keys }
  validate :owner_must_be_manager

  def owner_must_be_manager
    if Employee.by_id(owner_id)&.role != OWNER_ROLE 
      errors.add(:owner_id, "is not manager")
    end
  end
end
