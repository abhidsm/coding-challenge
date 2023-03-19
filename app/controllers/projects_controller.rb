class ProjectsController < ApplicationController
  before_action :set_project, only: %i[update]

  def index
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      @project
      @owner = Employee.by_id(@project.owner_id)
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      @project
      @owner = Employee.by_id(@project.owner_id)
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :state, :owner_id)
  end
end
