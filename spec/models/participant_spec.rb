require 'rails_helper'

RSpec.describe Participant, type: :model do
  subject {
    described_class.new(
      project_id: SecureRandom.uuid,
      employee_id: SecureRandom.uuid
    )
  }

  before(:each) do
    @manager = build(:employee, department: "HR", role: "manager")
    allow(Employee).to receive(:by_id).with(@manager.id).and_return(@manager) 
    @project = create(:project, owner_id: @manager.id)
    subject.project_id = @project.id
    @employee = build(:employee, department: "HR")
    allow(Employee).to receive(:by_id).with(subject.employee_id).and_return(@employee) 
  end

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

  it "is not valid if participant doesn't belogs to the manager department" do
    @accountant = build(:employee, department: "Finance")
    allow(Employee).to receive(:by_id).with(subject.employee_id).and_return(@accountant) 
    expect(subject).to_not be_valid
  end
end
