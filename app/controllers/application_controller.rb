class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers

  private

  helper_method :current_user
  def current_user
    @current_user ||= authenticate_by_session(Guest)
  end

  helper_method :current_user?
  def current_user? guest
    current_user == guest
  end

  def require_user!
    return if current_user
    save_passwordless_redirect_location!(Guest)
    redirect_to guests_sign_in_path
  end

  def require_dm!
    return if current_user.dungeon_master?
    redirect_to party_path(current_user.party)
  end
end
