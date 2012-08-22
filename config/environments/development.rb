BrightPeople::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.active_record.mass_assignment_sanitizer = :strict
  config.active_record.auto_explain_threshold_in_seconds = 0.5
  config.assets.compress = false
  config.assets.debug = true
  config.host_name = "http://localhost:3000"
  config.vk_public = '-40194424'
  config.fb_page_name = 'Mytestpage'
  config.fb_app_id = '245615425549849'
  config.fb_app_secret = '17849468bffdd53974e21bac98b397e9'
  # config.action_controller.asset_host = "http://buzzja.mine.nu"
end
