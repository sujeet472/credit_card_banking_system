class CreditCard < ApplicationRecord
    has_many :user_cards
  
    validates :type_of_card, presence: true
    validates :credit_limit, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :type_of_card, inclusion: { in: %w[silver gold platinum], message: "%{value} is not a valid card type" }
  
    before_create :generate_credit_card_id
   
    private
  
    def generate_credit_card_id
      # Get the next available reward number
      last_id = CreditCard.order(:id).last&.id
      next_number = last_id ? last_id[1..-1].to_i + 1 : 1 # Start from 1 if there are no records
  
      # Format the reward_id as R00(x), where (x) is the next number
      self.id = "CC#{next_number.to_s.rjust(3, '0')}"
    end
  
  
  end
  