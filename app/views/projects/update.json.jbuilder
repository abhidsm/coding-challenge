json.(@project, :id, :name, :owner_id, :state, :created_at, :updated_at)
json.owner do 
  json.(@owner, :id, :first_name, :last_name, :email, :role, :department)
end