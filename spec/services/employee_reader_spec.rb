require 'rails_helper'

RSpec.describe EmployeeReader, type: :model do

  before(:each) do 
    @json_data = build(:employee).instance_values
    stub_request(:get, "https://employees-api.vercel.app/employees").with(headers: {"Content-Type" => "application/json"}).to_return(:body => {data: [@json_data]}.to_json)
  end 

  it "creates employees from the response data" do 
    employees = EmployeeReader.call 
    expect(employees.first.first_name).to eq(@json_data["first_name"])
  end 

end