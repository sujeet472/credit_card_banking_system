class AccountTransactionsController < ApplicationController

    before_action :set_account_transaction, only: [:show, :destroy,:update, :undiscard]
  
    # GET /account_transactions
    def index
      @account_transactions = AccountTransaction.kept
    #   render json: @account_transactions
    end
  
    # GET /account_transactions/:id
    def show
      # render json: @account_transaction
      @account_transaction
    end
    

    def new
      @account_transaction = AccountTransaction.new
    end

    # POST /account_transactions
    def create
      @account_transaction = AccountTransaction.new(account_transaction_params)
      
      if @account_transaction.save
        
        redirect_to @account_transaction
        # render json: @account_transaction, status: :created
      else
        flash.now[:alert] = @account_transaction.errors.full_messages.join(", ")

        render json: @account_transaction.errors, status: :unprocessable_entity
      end
    end

    def edit
      @account_transaction = AccountTransaction.kept.find(params[:id]) 
    end
  
    # PATCH/PUT /account_transactions/:id
    def update
      if @account_transaction.update(account_transaction_params)
        render json: @account_transaction
      else
        render json: @account_transaction.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /account_transactions/:id (Soft Delete)
    def destroy
      @account_transaction.discard
      if @account_transaction.discard
        # @account_transaction.restore_available_limit
        render json: { message: "Transaction discarded successfully." }
      else
        render json: { error: "Failed to discard transaction." }, status: :unprocessable_entity
      end
    end
  
    # PATCH /account_transactions/:id/undiscard
    def undiscard
      if @account_transaction.undiscard
        # @account_transaction.reduce_available_limit
        render json: { message: "Transaction restored successfully." }
      else
        render json: { error: "Failed to restore transaction." }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_account_transaction
      @account_transaction = AccountTransaction.kept.find_by(id: params[:id])
      render json: { error: "Transaction not found" }, status: :not_found unless @account_transaction
    end
  
    def account_transaction_params
      params.require(:account_transaction).permit(:user_card_id, :amount, :merchant_id, :location, :transaction_type, :transaction_date)
    end
  end
  