require 'rails_helper'

RSpec.describe Participant, type: :model do
  subject {
    described_class.new(
      project_id: create(:project).id,
      employee_id: SecureRandom.uuid
    )
  }

  it "is valid with valid attributes" do 
    expect(subject).to be_valid
  end

  it "is not valid without project_id" do 
    subject.project_id = nil 
    expect(subject).to_not be_valid
  end

  it "is not valid without employee_id" do 
    subject.employee_id = nil 
    expect(subject).to_not be_valid
  end
end
