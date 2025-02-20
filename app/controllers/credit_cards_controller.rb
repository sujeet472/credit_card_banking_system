class CreditCardsController < ApplicationController
  def index
    @credit_cards = CreditCard.kept # This excludes soft-deleted records
  end
end