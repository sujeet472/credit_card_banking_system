class Reward < ApplicationRecord
  include Discard::Model
  
    # Associations
    belongs_to :account_transaction
    belongs_to :user_card
  
    # Validations
    validates :account_transaction_id, presence: true
    validates :user_card_id, presence: true
    validates :points_earned, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :points_redeemed, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    # Callbacks
    before_create :generate_reward_id
    before_save :update_last_updated
  
    private
  
    def generate_reward_id
      # Get the next available reward number
      last_id = Reward.order(:reward_id).last&.reward_id
      next_number = last_id ? last_id[1..-1].to_i + 1 : 1 # Start from 1 if there are no records
  
      # Format the reward_id as R00(x), where (x) is the next number
      self.reward_id = "R#{next_number.to_s.rjust(3, '0')}"
    end
  
    def update_last_updated
      self.last_updated = Time.current if self.points_earned_changed? || self.points_redeemed_changed?
    end
  end
  