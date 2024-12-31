Rails.application.config.content_security_policy do |policy|
  policy.connect_src :self, "http://localhost:3000"
end
