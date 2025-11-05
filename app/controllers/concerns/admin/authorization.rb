module Admin::Authorization
  extend ActiveSupport::Concern

  included do
    layout "admin"
    before_action :require_user!
    before_action :require_admin!
  end
end
