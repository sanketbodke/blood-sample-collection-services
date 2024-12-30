module Api
  module V1
    class RegistrationsController < ApplicationController
      def create
        user = User.new(user_params)

        if user.save
          role = params[:user][:is_lab] == 1 ? :lab : :patient
          user.add_role(role)

          render json: {
            user:,
            message: "User register successfully"
          }, status: :created

        else
          render json: {
            message: user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_lab)
      end
    end
  end
end
