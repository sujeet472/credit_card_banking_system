class RewardsController < ApplicationController

    before_action :set_reward, only: [:show, :update, :destroy, :undiscard]
  
    # GET /rewards
    def index
      @rewards = Reward.kept
    #   render json: @rewards
    end
  
    # GET /rewards/:id
    def show
      render json: @reward
    end
  
    # POST /rewards
    def create
      @reward = Reward.new(reward_params)
      
      if @reward.save
        render json: @reward, status: :created
      else
        render json: @reward.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /rewards/:id
    def update
      if @reward.update(reward_params)
        render json: @reward
      else
        render json: @reward.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /rewards/:id (Soft Delete)
    def destroy
      if @reward.discard
        render json: { message: "Reward discarded successfully." }
      else
        render json: { error: "Failed to discard reward." }, status: :unprocessable_entity
      end
    end
  
    # PATCH /rewards/:id/undiscard
    def undiscard
      if @reward.undiscard
        render json: { message: "Reward restored successfully." }
      else
        render json: { error: "Failed to restore reward." }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_reward
      @reward = Reward.find_by(id: params[:id])
      render json: { error: "Reward not found" }, status: :not_found unless @reward
    end
  
    def reward_params
      params.require(:reward).permit(:account_transaction_id, :user_card_id, :points_earned, :points_redeemed)
    end
  end
  