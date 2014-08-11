Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, '686458234757061', '730f8a21550df29c9fd5022c94fb2794'
end
