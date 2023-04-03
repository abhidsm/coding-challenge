class EmployeeReader < ApplicationService
  include HTTParty
  BASE_URI = Rails.configuration.settings.employee_api_base_uri 
  MAX_RETRIES = 3
  base_uri BASE_URI

  def call
    create_employees(format_data(fetch_data))
  end

  private

  def fetch_data 
    Rails.cache.fetch("employees_api", expires_in: 1.hour) do 
      fetch_data_from_api
    end
  end

  def format_data(json_data) 
    JSON.parse(json_data)["data"]
  end

  def create_employees(json_data)
    json_data.map do |employee_data|
      employee = Employee.new
      employee.from_json(employee_data.to_json)
    end
  end

  def fetch_data_from_api
    response = self.class.get(url, options)
    unless response.success?
      (MAX_RETRIES-1).times do 
        response = self.class.get(url, options)
        break if response.success?
      end
    end
    response.body
  end

  def url 
    "/employees"
  end

  def options
    { headers: {"accept" => "application/json"} }
  end

end