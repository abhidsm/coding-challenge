require 'rails_helper'

RSpec.describe EmployeeReader, type: :model do

  before(:each) do 
    base_uri = EmployeeReader::BASE_URI
    @json_data = build(:employee).instance_values
    stub_request(:get, "#{base_uri}/employees").with(headers: {"Accept" => "application/json"}).to_return(:body => {data: [@json_data]}.to_json)
  end 

  it "creates employees from the response data" do 
    employees = EmployeeReader.call 
    expect(employees.first.first_name).to eq(@json_data["first_name"])
  end 

end