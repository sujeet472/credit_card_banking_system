class UserCard < ApplicationRecord
    belongs_to :credit_card
    belongs_to :customer
  
    validates :credit_card_id, presence: true
    validates :customer_id, presence: true
    validates :issue_date, presence: true
    validates :expiry_date, presence: true
    validates :cvv, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 999 }
    validates :is_active, inclusion: { in: [true, false] }
    validates :available_limit, presence: true, numericality: { greater_than_or_equal_to: 0 }
  

    # Virtual attribute to handle CVV input
    attr_accessor :cvv

    # Automatically generate user_card_id in the format UC00x
    before_create :generate_user_card_id
  
    private
  
    def generate_user_card_id
      # Assuming 'UC00' + a unique number, here using ActiveRecord's `id` to generate a sequential number
      self.user_card_id ||= "UC#{sprintf('%04d', self.class.count + 1)}"
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

  