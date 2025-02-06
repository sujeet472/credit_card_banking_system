class Branch < ApplicationRecord
  include Discard::Model
  
    has_many :customers
  
    validates :branch_name, presence: true, length: { maximum: 50 }
    validates :branch_address, presence: true
    validates :branch_manager, presence: true, length: { maximum: 50 }
    validates :branch_phone, presence: true, uniqueness: true, length: { maximum: 15 }
    validates :branch_email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: URI::MailTo::EMAIL_REGEXP }

    before_discard do
      customers.discard_all
    end

    after_undiscard do
      customers.undiscard_all
    end

    before_create :generate_branch_id
   
  
    private
  
    def generate_branch_id
      # Get the next available reward number
      last_id = Branch.order(:id).last&.id
      next_number = last_id ? last_id[1..-1].to_i + 1 : 1 # Start from 1 if there are no records
  
      # Format the reward_id as R00(x), where (x) is the next number
      self.id = "B#{next_number.to_s.rjust(3, '0')}"
    end

    
  end
  