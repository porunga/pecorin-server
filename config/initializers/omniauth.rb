Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '114861545309251', '********************'
end
