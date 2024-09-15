class PartiesController < ApplicationController
  # before_action :redirect_because_rsvps_are_closed, only: [:new, :create, :onboarding]

  before_action :require_user!, except: [:new, :create]
  before_action :set_user_party, only: [:edit, :update, :onboarding, :show]

  def show
    @og_image = "og-party.jpg"
  end

  def new
    redirect_to onboarding_path if current_user
    @party = Party.new
    @party.guests.build
  end

  def create
    @party = Party.new(party_params)

    # before we attempt to save, check if this is someone trying to login
    if Guest.exists?(email: @party.guests.first.email)
      redirect_to onboarding_path and return
    end

    if @party.save
      sign_in(create_passwordless_session(@party.guests.first)) unless current_user&.dungeon_master?

      redirect_to onboarding_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def onboarding
    if @party.rsvp
      @additional_guests = @party.guests.reject { |guest| guest == current_user }
    else
      render :declined
    end
  end

  def edit
    redirect_to onboarding_path
  end

  def update
    if @party.update(party_params)
      redirect_to party_path(@party)
      notify_dms
    else
      render_referrer = request.referer&.include?(onboarding_path) ? :onboarding : :edit
      render render_referrer, status: :unprocessable_entity
    end
  end

  private

  def redirect_because_rsvps_are_closed
    flash[:notice] = "RSVPs are closed!"

    if current_user
      redirect_to party_path
    else
      redirect_to root_path
    end
  end

  def set_user_party
    @party ||= current_user.party
  end

  def validate_guest_preferences
    @party.guests.each(&:validate_preferences)
  end

  def notify_dms
    guest_list = []

    if @party.rsvp
      @party.guests.each do |guest|
        guest_list << "- #{guest.name} (#{guest.feast}, #{guest.guild.name})"
      end
    end

    DungeonMasterNotifier.notify(
      "#{@party.guests.first.name} responded!",
      <<~BODY
        #{@party.name} rsvp'd '#{@party.rsvp ? "accept" : "can’t make it"}'.

        #{guest_list.join("\n")}

        DM Screen: #{dungeon_master_root_url}
        Email them: #{@party.guests.first.email}
      BODY
    )
  end

  def party_params
    params.require(:party).permit(
      :name,
      :rsvp,
      :notes,
      guests_attributes: [
        :id,
        :name,
        :email,
        :under_13,
        :food_preference,
        :notes
      ]
    )
  end
end
