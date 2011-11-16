Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV['GOOGLE_OAUTH2_CLIENT_ID'],
    ENV['GOOGLE_OAUTH2_CLIENT_SECRET'],
    :scope => [
#      "https://www.googleapis.com/auth/userinfo.profile",
#      "https://www.googleapis.com/auth/plus.me",
    ].join(",")
end