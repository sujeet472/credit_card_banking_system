class CreditCard < ApplicationRecord
  include Discard::Model
  
    has_many :user_cards
  
    validates :type_of_card, presence: true
    validates :credit_limit, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :type_of_card, inclusion: { in: %w[silver gold platinum], message: "%{value} is not a valid card type" }
  
    before_discard do
      user_cards.discard_all
    end

    after_undiscard do
      user_cards.undiscard_all
    end

    before_create :generate_credit_card_id
   
    private
  
    def generate_credit_card_id
      last_id = CreditCard.order(:id).last&.id
      next_number = last_id.present? ? last_id[2..-1].to_i + 1 : 1 
      self.id = "CC#{next_number.to_s.rjust(3, '0')}"
    end
  end
