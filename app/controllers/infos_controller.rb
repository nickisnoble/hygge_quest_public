class InfosController < ApplicationController
  def registry
    @og_image = "og-registry.jpg"
  end

  def home
  end

  def map
    @og_image = "og-map.jpg"
  end

  private

  def ward un, pw
    return if Rails.env.development?
    authenticate_or_request_with_http_basic do |username, password|
      username == un && password == pw
    end
  end
end
