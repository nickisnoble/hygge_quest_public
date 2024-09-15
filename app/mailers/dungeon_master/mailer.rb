class DungeonMaster::Mailer < ApplicationMailer
  def notify(subject, body)
    @body = body
    @first, *@rest = Guest.where(dungeon_master: true)

    if @rest.any?
      mail(
        to: @first.email,
        subject: subject,
        cc: @rest.map(&:email)
      )
    else
      mail(
        to: @first.email,
        subject: subject
      )
    end
  end
end
