class GuildsController < ApplicationController
  before_action :set_og_image

  def index
    @guilds = Guild.joinable
  end

  def show
    @guild = Guild.with_attached_looks.find_by!(slug: params[:id])
  end

  private

  def set_og_image
    @og_image = "og-guilds.jpg"
  end
end
