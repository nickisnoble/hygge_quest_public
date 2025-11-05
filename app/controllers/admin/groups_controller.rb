class Admin::GroupsController < ApplicationController
  include Admin::Authorization

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:notice] = "#{@group.name} created!"
      redirect_to admin_groups_path
    else
      flash[:error] = @group.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "#{@group.name} updated!"
      redirect_to admin_groups_path
    else
      flash[:error] = @group.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    flash[:notice] = "Group deleted"
    redirect_to admin_groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
