class Customer < ApplicationRecord
    belongs_to :branch, optional: true
    has_many :user_cards
  
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :date_of_birth, presence: true
    validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, presence: true, uniqueness: true, length: { maximum: 15 }
    validates :address, presence: true
    validates :profile_image, length: { maximum: 255 }, allow_nil: true
    validates :account_type, inclusion: { in: %w[saving current salary], message: "%{value} is not a valid account type" }

    before_create :generate_customer_id
   
    private
  
    def generate_customer_id
      # Get the next available reward number
      last_id = Customer.order(:id).last&.id
      next_number = last_id ? last_id[1..-1].to_i + 1 : 1 # Start from 1 if there are no records
  
      # Format the reward_id as R00(x), where (x) is the next number
      self.id = "C#{next_number.to_s.rjust(3, '0')}"
    end
  end
  