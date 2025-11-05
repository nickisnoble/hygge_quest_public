class AdminNotifier
  def self.notify(subject, body)
    Admin::Mailer.notify(
      subject, body
    ).deliver_now
  end
end
