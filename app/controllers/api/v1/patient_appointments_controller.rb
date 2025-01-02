module Api
  module V1
    class PatientAppointmentsController < BaseController
      before_action :set_appointment, only: [ :update, :destroy ]

      def index
        @appointments = @current_user.patientAppointments.includes(:agent)
        render json: { appointments: @appointments, message: "Appointments fetched successfully" }, status: :ok
      end

      def create
        appointment = @current_user.patientAppointments.build(appointment_params)

        UserMailer.appointment_scheduled(appointment).deliver_now

        if appointment.save
          render json: { appointment:, message: "Appointment scheduled successfully" }, status: :created
        else
          render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @appointment.update(appointment_params)
          render json: { appointment: @appointment, message: "Appointment updated successfully" }, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @appointment.destroy
          render json: { message: "Appointment deleted successfully" }, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_appointment
        @appointment = @current_user.patientAppointments.find(params[:id])
      end

      def appointment_params
        params.require(:patient_appointment).permit(:agent_id, :appointment_time, :test_type, :collection_location, :note)
      end
    end
  end
end
