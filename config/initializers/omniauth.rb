OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '318107781637293', 'd3710be636ede1e4ba22d809e237fde1'
end

