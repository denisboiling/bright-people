require 'active_admin_autocomple_filter'

ActiveAdmin.setup do |config|
  config.site_title = "Bright People"
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  config.register_javascript '//api-maps.yandex.ru/2.0/?load=package.full&lang=ru-RU'
  config.register_javascript 'edit_map'
  config.register_javascript 'cocoon'
  config.register_javascript 'autocomplete-rails'

  config.before_filter :set_admin_locale

  def set_admin_locale
    I18n.locale = :ru
  end
end
