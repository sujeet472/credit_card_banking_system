class AccountTransaction < ApplicationRecord
  include Discard::Model
  
    belongs_to :user_card
    belongs_to :merchant, class_name: "Customer", foreign_key: "merchant_id"
  
    validates :user_card_id, presence: true
    validates :transaction_date, presence: true
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :merchant_id, presence: true
    validates :transaction_type, presence: true, inclusion: { in: ['purchase', 'refund', 'adjustment'] }
  

    # before_discard do
    #   rewards.discard_all
    # end

    # after_undiscard do
    #   rewards.undiscard_all
    # end

    # Automatically generate account_transaction_id in the format T00(x)
    before_create :generate_account_transaction_id
  
    private
  
    def generate_account_transaction_id
      # Get the next available reward number
      last_id = AccountTransaction.order(:id).last&.id
      next_number = last_id ? last_id[1..-1].to_i + 1 : 1 # Start from 1 if there are no records
  
      # Format the reward_id as R00(x), where (x) is the next number
      self.id = "T#{next_number.to_s.rjust(3, '0')}"
    end
  end
  