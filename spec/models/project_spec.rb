require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "manager" do
    subject {
      described_class.new(
        name: "Acme",
        owner_id: SecureRandom.uuid,
        state: "active"
      )
    }

    before(:each) do
      @manager = build(:employee, role: "manager")
      allow(Employee).to receive(:by_id).and_return(@manager) 
    end

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

    it "is not valid if owner doesn't exist" do
      allow(Employee).to receive(:by_id).and_return(nil) 
      expect(subject).to_not be_valid
    end
  end
  
  it "is not valid if owner role is not manager" do
    developer = build(:employee, role: "developer")
    allow(Employee).to receive(:by_id).and_return(developer) 
    subject.owner_id = developer.id 
    expect(subject).to_not be_valid
  end
end
