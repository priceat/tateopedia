Devise.setup do |config|
 
  config.mailer_sender = 'priceat@gmail.com'

  config.secret_key = '584d17a483d592b2ae488c029fc899c4e21a262bc47dc6cdb767dea22db2720e0cae1107a922e43d96b1bb8c6c1900828b95e8e861ab6899334809debd7948b5'

  config.case_insensitive_keys = [ :email ]
 
  config.strip_whitespace_keys = [ :email ]
  
  config.skip_session_storage = [:http_auth]
  
  config.stretches = Rails.env.test? ? 1 : 10
 
  config.reconfirmable = true
 
  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..128
  
  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

end
