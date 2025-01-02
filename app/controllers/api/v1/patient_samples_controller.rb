module Api
  module V1
    class PatientSamplesController < BaseController
      before_action :set_appointment, only: [ :update ]

      def index
        @agents = @current_user.lab.agents
        @appointments = PatientAppointment.where(agent_id: @agents.pluck(:id))

        render json: { appointments: @appointments, message: "Appointments Fetched Successfully" }, status: :ok
      end

      def update
        if @appointment.update(appointment_params)
          render json: { appointment: @appointment, message: "Appointment Status Updated" }, status: :ok
        else
          render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_appointment
        @appointment = PatientAppointment.find(params[:id])
      end

      def appointment_params
        params.require(:patient_appointment).permit(:status)
      end
    end
  end
end
