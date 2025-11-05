class PagesController < ApplicationController
  def show
    @page = Page.published.find_by!(slug: params[:slug])
  end
end
