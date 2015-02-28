Rails.application.configure do
  config.action_mailer.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :enable_starttls_auto => true,
    :user_name => ENV["MANDRILL_USERNAME"],
    :password  => ENV["MANDRILL_APIKEY"],
    :authentication => "plain",
    :domain => "aspiringwebdev.com"
  }
end