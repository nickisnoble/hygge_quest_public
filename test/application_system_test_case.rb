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
end
