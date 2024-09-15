class DungeonMaster::MailingsController < ApplicationController
  include DungeonMaster::Cerberus

  def index
    @mailings = Mailing.all
  end

  def show
    @mailing = Mailing.find(params[:id])
  end

  def new
    @mailing = Mailing.new
  end

  def create
    @mailing = Mailing.new(mailing_params)

    failed = []

    if @mailing.save
      Rails.logger.info "=== SENDING '#{@mailing.subject}'"

      @mailing.guests.each do |guest|
        Rails.logger.info "Sending to #{guest.name}..."
        if guest.email.blank?
          Rails.logger.info "skipping since they don't have an email"
          next
        end

        begin
          GuestMailer.info_email(@mailing, guest).deliver_now
          Rails.logger.info "SENT to #{guest.name}"
        rescue => e
          Rails.logger.error "Couldn't send due to error: #{e.message}"
          failed << guest.name
        end
      end
      Rails.logger.info "=== DONE SENDING"

      if failed.any?
        Rails.logger.error "FAILED SENDING: #{failed.join(", ")}"
        flash[:error] = "Failed to send to: #{failed.join(", ")}" if failed.any?
      else
        flash[:success] = "Sent to #{@mailing.guests.count} guests!"
      end

      redirect_to [:dungeon_master, @mailing]
    else
      flash[:error] = @mailing.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def mailing_params
    params.require(:mailing).permit(:subject, :body, guest_ids: [])
  end
end
