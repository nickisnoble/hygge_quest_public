class DungeonMasterNotifier
  def self.notify(subject, body)
    DungeonMaster::Mailer.notify(
      subject, body
    ).deliver_now
  end
end
