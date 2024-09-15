class DungeonMaster::GuildsController < ApplicationController
  include DungeonMaster::Cerberus

  before_action :set_guild, only: [:update, :edit]

  def index
    @guilds = Guild.all
  end

  def edit
  end

  def update
    if params[:remove_looks].present?
      params[:remove_looks].each do |id|
        attachment = ActiveStorage::Attachment.find_by(id: id)

        if attachment.present?
          attachment.purge
          # Remove the ID from the looks array
          params[:guild][:looks].reject! { |look| look == attachment.blob.signed_id }
        end
      end
    end

    if @guild.update(guild_params)
      flash[:notice] = "#{@guild.name} updated!"
      redirect_to edit_dungeon_master_guild_path(@guild)
    else
      flash[:error] = @guild.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_guild
    @guild = Guild.with_attached_looks.find_by(slug: params[:id])
  end

  def guild_params
    params.require(:guild).permit(:description, :secret, :icon, :background, looks: [])
  end
end
