require 'rails_helper'

RSpec.describe Project, type: :model do
  subject {
    described_class.new(
      name: "Acme",
      owner_id: SecureRandom.uuid,
      state: "active"
    )
  }

  it "is valid with valid attributes" do 
    expect(subject).to be_valid
  end 

  it "is not valid without name" do 
    subject.name = nil 
    expect(subject).to_not be_valid
  end 

  it "is not valid without owner" do 
    subject.owner_id = nil 
    expect(subject).to_not be_valid
  end 

  it "is not valid without state" do 
    subject.state = nil 
    expect(subject).to_not be_valid
  end

  it "is not valid if state is not any of planned, active, done, failed" do 
    expect {subject.state = "started"}.to raise_error(ArgumentError)
  end
end
