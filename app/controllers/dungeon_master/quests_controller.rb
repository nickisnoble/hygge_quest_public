class DungeonMaster::QuestsController < ApplicationController
  include DungeonMaster::Cerberus
  before_action :set_quest, only: [:show, :edit, :update, :destroy]

  def index
    @quests = Quest.all
  end

  def show
  end

  def new
    @quest = Quest.new
    render :edit
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      flash.now[:success] = "Quest added!"

      render turbo_stream: [
        turbo_stream.append("quests", partial: "quest", locals: {quest: @quest}),
        helpers.render_flash_stream
      ]
    else
      flash[:error] = "Couldn't save this quest!"
      render :edit
    end
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      flash.now[:notice] = "Quest was successfully updated."

      render turbo_stream: [
        turbo_stream.update(@quest),
        helpers.render_flash_stream
      ]
    else
      flash[:error] = "Couldn't save this quest!"
      render :edit
    end
  end

  def destroy
    @quest.destroy
    flash[:notice] = "Quest removed"
    redirect_to dungeon_master_quests_url
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title, :description, :xp, :reward)
  end
end
