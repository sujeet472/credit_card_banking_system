class AccountTransaction < ApplicationRecord
    belongs_to :user_card
    belongs_to :merchant, class_name: "Customer", foreign_key: "merchant_id"
  
    validates :user_card_id, presence: true
    validates :transaction_date, presence: true
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :merchant_id, presence: true
    validates :transaction_type, presence: true, inclusion: { in: ['purchase', 'refund', 'adjustment'] }
  
    # Automatically generate account_transaction_id in the format T00(x)
    before_create :generate_account_transaction_id
  
    private
  
    def generate_account_transaction_id
      self.account_transaction_id ||= "T00#{sprintf('%04d', self.class.count + 1)}"
    end
  end
  