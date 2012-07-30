require 'active_admin_autocomple_filter'

# module ActiveAdmin
#   # Implement dynamic role for mass assignment security.
#   class BaseController
#     protected
#     def role_given?
#       current_admin_user.role
#     end

#     def as_role
#       { as: current_admin_user.role.name.downcase.to_sym }
#     end
#   end
# end

ActiveAdmin.setup do |config|
  config.site_title = "Bright People"
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  # because our main script placed in not standard place,
  # we should remove and and new path explicitly:
  config.javascripts.delete 'active_admin.js'
  config.register_javascript 'admin/active_admin'

  config.stylesheets.pop
  config.register_stylesheet 'admin/active_admin'

  config.register_javascript '//api-maps.yandex.ru/2.0/?load=package.full&lang=ru-RU'

  config.before_filter :set_admin_locale

  def set_admin_locale
    I18n.locale = :ru
  end
end
