module Api
  module V1
    class LabsController < BaseController
      before_action :set_lab, only: [ :update ]
      def create
        @lab = @current_user.build_lab(lab_params)

        if @lab.save
          render json: { lab: @lab, message: "Lab Created Successfully" }, status: :created
        else
          render json: { message: @lab.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @lab = @current_user.lab

        if @lab.update(lab_params)
          render json: { lab: @lab, message: "Lab updated" }
        else
          render json: { message: @lab.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_lab
        @lab = Lab.find_by(params[:id])
      end

      def lab_params
        params.require(:lab).permit(:name, :email, :phone)
      end
    end
  end
end
