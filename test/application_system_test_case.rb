require "test_helper"
require "capybara/cuprite"

# Capybara.server_port = 55996

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chromium, screen_size: [1400, 1400]

  setup do
    host, port = Capybara.current_session.server.host, Capybara.current_session.server.port
    Rails.application.routes.default_url_options[:host] = host
    Rails.application.routes.default_url_options[:port] = port
  end

  private

  def wait_for_turbo
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until page.evaluate_script('document.documentElement.hasAttribute("data-turbo-busy")') == false
    end
  end

  # Helper to sign in a guest by directly creating a session
  def sign_in_guest(guest)
    # Create a passwordless session and set the cookie
    session = Passwordless::Session.create!(
      authenticatable: guest,
      user_agent: "Test",
      remote_addr: "127.0.0.1",
      timeout_at: 1.hour.from_now
    )

    # Visit the magic link directly
    visit polymorphic_path(
      [:guests, :session],
      token: session.token
    )
  end
end
