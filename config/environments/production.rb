BrightPeople::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  config.action_controller.asset_host = "http://images.bright-people.ru"
  config.assets.precompile += %w( admin/active_admin.js
                                  admin/active_admin.css
                                  chosen.jquery.min.js
                                  dashboard/*.js)
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  config.middleware.use ExceptionNotifier, :email_prefix => "[Notify bright-people] ",
                                           :sender_address => %{"notify"},
                                           :exception_recipients => %w{ kremenev@balticit.ru }
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
end
