module ApplicationHelper
  def auth_link
    if current_user
      link_to("Logout", guests_sign_out_url)
    else
      link_to("Login", guests_sign_in_url)
    end
  end

  def render_flash_stream
    turbo_stream.update "flash", partial: "shared/flash"
  end
end
