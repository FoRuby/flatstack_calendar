ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: Rails.application.credentials[:sendgrid][:api_key],
  domain: 'https://vast-crag-74622.herokuapp.com/',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
