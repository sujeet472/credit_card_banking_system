class UserCard < ApplicationRecord
  include Discard::Model
  
    belongs_to :credit_card
    belongs_to :customer
    has_many :rewards
    has_many :account_transactions

    validates :credit_card_id, presence: true
    validates :customer_id, presence: true
    validates :issue_date, presence: true
    validates :expiry_date, presence: true
    validates :cvv, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 999 }
    validates :is_active, inclusion: { in: [true, false] }
    validates :available_limit, presence: true, numericality: { greater_than_or_equal_to: 0 }
  

    before_discard do
      rewards.discard_all
      account_transactions.discard_all
    end

    after_undiscard do
      rewards.undiscard_all
      account_transactions.undiscard_all
    end


    # Virtual attribute to handle CVV input
    attr_accessor :cvv

    # Automatically generate user_card_id in the format UC00x
    before_create :generate_user_card_id
    before_save :hash_cvv
  
    private
    def generate_user_card_id
      # Get the next available reward number
      last_id = UserCard.order(:id).last&.id
      next_number = last_id ? last_id[1..-1].to_i + 1 : 1 # Start from 1 if there are no records
  
      # Format the reward_id as R00(x), where (x) is the next number
      self.id = "UC#{next_number.to_s.rjust(3, '0')}"
    end

    def hash_cvv
      if cvv.present?
        self.hashed_cvv = BCrypt::Password.create(cvv)
      end
    end
  end


# **********************when you will create authentication for cvv***************

# def authenticate_cvv(input_cvv)
#   BCrypt::Password.new(self.hashed_cvv) == input_cvv
# end


# user_card = UserCard.find_by(user_card_id: "UC0001")
# if user_card.authenticate_cvv(742)
#   puts "CVV is correct"
# else
#   puts "Invalid CVV"
# end

  