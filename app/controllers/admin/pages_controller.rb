class Admin::PagesController < ApplicationController
  include Admin::Authorization

  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all.order(:title)
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:notice] = "Page created successfully"
      redirect_to admin_pages_path
    else
      flash[:error] = @page.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      flash[:notice] = "Page updated successfully"
      redirect_to admin_pages_path
    else
      flash[:error] = @page.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = "Page deleted"
    redirect_to admin_pages_path
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :slug, :content, :published)
  end
end
