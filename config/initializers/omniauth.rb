OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
# end

# use OmniAuth::Builder do
#   provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
# end

CALLBACK_URL = 'http://localhost:3000/auth/google_oauth2/callback'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},
    scope: 'email profile',
    access_type: 'online',
    setup: (lambda do |env|
      request = Rack::Request.new(env)
      env['omniauth.strategy'].options['token_params'] = {:redirect_uri => CALLBACK_URL }
    end)
}
end
