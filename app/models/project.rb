class Project < ApplicationRecord
  enum :state, { planned: 0, active: 1, done: 2, failed: 3 }, suffix: true

  validates_presence_of :name, :owner_id, :state
  validates :state, inclusion: { in: states.keys }
  validate :owner_must_be_manager

  def owner_must_be_manager
    if Employee.by_id(self.owner_id).try(:role) != "manager" 
      errors.add(:owner_id, "is not manager")
    end
  end
end
