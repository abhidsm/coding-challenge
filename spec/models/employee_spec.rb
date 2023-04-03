require 'rails_helper'

RSpec.describe Employee, type: :model do

  before(:each) do 
    @employee = build(:employee)
  end

  it "parse a json and creates an object" do 
    json = @employee.attributes
    new_employee = Employee.new
    new_employee.from_json(json.to_json)
    expect(new_employee.first_name).to eq(@employee.first_name)
  end 

  it "returns the employee by id" do 
    second_employee = build(:employee)
    allow(EmployeeReader).to receive(:call).and_return([@employee, second_employee]) 
    result = Employee.by_id(second_employee.id)
    expect(result.first_name).to eq(second_employee.first_name)
  end
end
