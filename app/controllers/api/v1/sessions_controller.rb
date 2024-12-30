module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])

        if user&.valid_password?(params[:password])
          token = JwtHelper.encode(user_id: user.id)

          render json: {
            status: "success",
            user:,
            token:,
            role: user.roles_name.first
          }, status: :ok
        else
          render json: {
            status: "error",
            message: "Invalid email or password "
          }, status: :unauthorized
        end
      end
    end
  end
end
