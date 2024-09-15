class GuestsController < ApplicationController
  before_action :require_user!
  before_action :set_guest, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @guest = Guest.new(under_13: params[:under_13].present?)
    @guest.party = Party.find(params[:party_id]) if params[:party_id].present? && current_user.dungeon_master?
    @guest.party ||= current_user.party
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.party ||= current_user.party
    @guest.under_13 = false if @guest.under_13.nil?

    validate_preferences

    if @guest.errors.empty? && @guest.save
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    validate_preferences
    # need to manually check for error because we add our own in certain cases (see validate_preferences)
    if @guest.errors.empty? && @guest.update(guest_params)
      flash[:success] = "Character saved!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @guest.destroy
  end

  private

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def validate_preferences
    if @guest != current_user
      unless guest_params[:food_preference].present?
        @guest.errors.add(:food_preference, "must be set")
      end

      unless guest_params[:guild_id].present?
        @guest.errors.add(:guild_id, "must be chosen")
      end
    end
  end

  def guest_params
    params.require(:guest)
      .permit(
        :name, :email, :under_13, :food_preference, :notes, :party_id, :guild_id
      )
  end
end
