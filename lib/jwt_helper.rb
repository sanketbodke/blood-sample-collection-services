require "jwt"

module JwtHelper
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    return  nil if token.nil?

    decoded = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new(decoded)

  rescue JWT::DecodeError
    nil
  end
end
