class UserMailer < ApplicationMailer
  def appointment_scheduled(appointment)
    @appointment = appointment
    @lab = @appointment.agent.lab
    @patient = @appointment.user

    mail(
      to: @lab.user.email,
      cc: @appointment.agent.email,
      subject: "New Appointment Scheduled"
    )
  end

  def otp(user, otp_code)
    @user = user
    @otp_code = otp_code
    mail(to: @user.email, subject: "Your OTP Code")
  end
end
