class Api::V1::AuthController < ApplicationController
    before action: login_params

    def login
        sign_in login_params[:email], login_params[:password]
        render json: {"message": "successfull"}, status: :ok
    rescue 
        render json: {error: "login failed"}, status: :404
    end

    def login_params
        params.permit(:email, :password)
    end
    
end
