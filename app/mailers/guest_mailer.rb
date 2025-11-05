class GuestMailer < ApplicationMailer
  def info_email(mailing, guest)
    return unless guest.email # not all guests have emails
    @guest = guest
    @mailing = mailing

    admin_emails = Guest.where(admin: true).pluck(:email)

    mail(
      to: @guest.email,
      reply_to: admin_emails,
      subject: @mailing.subject,

      template_path: "guests/mailers",
      template_name: "info_email"
    )
  end
end
