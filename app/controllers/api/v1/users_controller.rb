module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: %w[update send_otp reset_password]

      def update
        @user = @current_user

        if @user.update(user_params)
          if @user.save
            render json: { message: "User Updated", user: @user }, status: :ok
          else
            render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end

      def send_otp
        otp_code = generate_otp_code
        @user.update(otp_code:, otp_generated_at: Time.current)
        UserMailer.otp(@user, otp_code).deliver_now
        render json: { message: "OTP sent successfully" }, status: :ok
      end

      def reset_password
        if params[:otp_code] == @user.otp_code && otp_not_expired?(@user)
          user_service = UserService.new(@user)
          password_update = user_service.reset_password(
            params[:current_password], params[:new_password], params[:confirm_new_password]
          )

          if password_update == "Password Updated"
            @user.update(otp_code: nil, otp_generated_at: nil)
            render json: { message: "Password updated successfully" }, status: :ok
          else
            render json: { error: password_update }, status: :unprocessable_entity
          end
        else
          render json: { error: "Invalid or expired OTP" }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :phone, :dob, :gender, :blood_group, address_attributes: [ :street, :city, :state, :zip ])
      end

      def generate_otp_code
        rand(1000..9999)
      end

      def otp_not_expired?(user)
        user.otp_generated_at && user.otp_generated_at > 10.minutes.ago
      end
    end
  end
end
