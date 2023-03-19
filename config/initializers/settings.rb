class Settings
  class << self
    def employee_api_base_uri
      ENV["EMPLOYEE_API_BASE_URI"]
    end

    def project_owner_role
      ENV["PROJECT_OWNER_ROLE"]
    end
  end
end