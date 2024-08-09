module Api
  module V1
    class AuthenticationController < ApplicationController
    	
      def signup
        user = User.new(user_params)
        if user.save
          render json: { message: 'User created successfully' }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: 400
        end
      end

      def signin
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: {
          	user: user, 
          	token: token }, status: :ok
        else
          render json: { errors: 'Invalid email or password' }, status: 400
        end
      end

      private

      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end