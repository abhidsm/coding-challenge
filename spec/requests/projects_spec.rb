require 'rails_helper'

RSpec.describe "Projects", type: :request do
  
  describe "GET /" do
    it "returns http success" do
      get "/projects", as: :json
      expect(response).to have_http_status(:success)
    end

    it "returns projects" do
      project = build(:project)
      project.save(validate: false)
      get "/projects", as: :json
      json = JSON.parse(response.body)
      ["id", "name", "owner_id", "state"].each do |field_name|
        expect(json.first[field_name]).to eq(project.send(field_name))
      end
    end
  end

  describe "POST /" do
    
    before(:each) do
      @manager = build(:employee, role: Project::OWNER_ROLE)
      allow(Employee).to receive(:by_id).and_return(@manager) 
      @project = build(:project)
      data = {project: {name: @project.name, owner_id: @project.owner_id, state: @project.state}}
      post "/projects", params: data, as: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns project details" do
      json = JSON.parse(response.body)
      ["name", "owner_id", "state"].each do |field_name|
        expect(json[field_name]).to eq(@project.send(field_name))
      end
      expect(json["owner"]["first_name"]).to eq(@manager.first_name)
    end
  end

  describe "PUT /:id" do
    
    before(:each) do
      @manager = build(:employee, role: Project::OWNER_ROLE)
      allow(Employee).to receive(:by_id).and_return(@manager) 
      project = build(:project)
      project.save(validate: false)
      @data = {id: project.id, project: {name: "New Name", owner_id: project.owner_id, state: project.state}}
      put "/projects/#{project.id}", params: @data, as: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns updated project details" do
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(@data[:project][:name])
      expect(json["owner"]["email"]).to eq(@manager.email)
    end
  end

end
