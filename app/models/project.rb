class Project < ApplicationRecord
  enum :state, { planned: 0, active: 1, done: 2, failed: 3 }, suffix: true

  validates_presence_of :name, :owner_id, :state
  validates :state, inclusion: { in: states.keys }
end
