class GuestMailer < ApplicationMailer
  def info_email(mailing, guest)
    return unless guest.email # not all guests have emails
    @guest = guest
    @mailing = mailing

    dm_emails = Guest.where(dungeon_master: true).pluck(:email)

    mail(
      to: @guest.email,
      reply_to: dm_emails,
      subject: @mailing.subject,

      template_path: "guests/mailers",
      template_name: "info_email"
    )
  end
end
