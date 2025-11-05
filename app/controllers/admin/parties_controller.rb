class Admin::PartiesController < PartiesController
  include Admin::Authorization
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  def index
    @parties = Party.all
    @attending = Guest.attending
  end

  def show
  end

  def edit
  end

  def update
    if @party.update(party_params)
      redirect_to [:admin, @party], notice: "Party was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @party.destroy
    redirect_to admin_parties_path
  end

  private

  def set_party
    @party = Party.find(params[:id])
  end

  def party_params
    params.require(:party).permit(
      :name,
      :rsvp,
      :notes,
      :response_deadline,
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
