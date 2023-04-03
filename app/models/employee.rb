class Employee 
  include ActiveModel::Serializers::JSON
  ATTRIBUTES = %w(id first_name last_name email department role).freeze
  attr_accessor :id, :first_name, :last_name, :email, :department, :role

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value) if ATTRIBUTES.include?(key)
    end
  end

  def attributes
    instance_values
  end

  def self.by_id(id)
    @_employees ||= EmployeeReader.call.index_by(&:id)
    @_employees[id]
  end
end
