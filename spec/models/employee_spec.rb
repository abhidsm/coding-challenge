require 'rails_helper'

RSpec.describe Employee, type: :model do

  it "parse a json and creates an object" do 
    json = {
      id: SecureRandom.uuid, 
      first_name: Faker::Name.first_name , 
      last_name: Faker::Name.last_name , 
      email: Faker::Internet.email, 
      department: Faker::Company.industry, 
      role: Faker::Company.profession
    }

    employee = Employee.new
    employee.from_json(json.to_json)
    expect(employee.first_name).to eq(json[:first_name])
  end 

  it "returns the employee by id" do 
    first_employee = build(:employee)
    second_employee = build(:employee)
    allow(EmployeeReader).to receive(:call).and_return([first_employee, second_employee]) 
    result = Employee.by_id(second_employee.id)
    expect(result.first_name).to eq(second_employee.first_name)
  end
end
