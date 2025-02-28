class Api::V1::BranchesController < ApplicationController
    before_action :set_branch, only: %i[show update destroy]
  
    def index
      render json: Branch.kept.all
    end
  
    def show
      render json: @branch
    end
  
    def create
      branch = Branch.new(branch_params)
      if branch.save
        render json: branch, status: :created
      else
        render json: branch.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @branch.update(branch_params)
        render json: @branch
      else
        render json: @branch.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @branch.destroy
      head :no_content
    end

    def discard
      if @branch.discard
          render json: {message: "Branch discarded successfully"}, status: :ok
      else
          render json: {error: "Failed to discard Branch"}, status: :unprocessable_entity
      end
    end

  
  def restore
      @branch = Branch.with_discarded.kept.find(params[:id])
      if @branch.undiscard
          render json: {message: "Branch restored successfully"}, status: :ok
      else
          render json: {error: "Failed to restore Branch"}, status: :unprocessable_entity
      end
  end
  
    private
  
    def set_branch
      @branch = Branch.kept.find(params[:id])
    end
  
    def branch_params
      params.require(:branch).permit(:branch_name, :branch_address, :branch_manager, :branch_phone, :branch_email)
    end
end