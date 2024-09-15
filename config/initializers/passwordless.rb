Passwordless.configure do |config|
  config.default_from_address = ENV.fetch("DEFAULT_FROM_EMAIL")
  config.restrict_token_reuse = false # Can a token/link be used multiple times?

  config.redirect_back_after_sign_in = true # When enabled the user will be redirected to their previous page, or a page specified by the `destination_path` query parameter, if available.
  # config.success_redirect_path = '/party' # After a user successfully signs in
end
