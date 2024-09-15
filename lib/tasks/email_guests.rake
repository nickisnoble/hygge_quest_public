# This was before the mailer was implemented in DM.
# It's just here as a reference.
# I would never do this unless you are SURE you only need to send one email to everyone...
# And even then, that's what *I* thought.
# Just build the mailer, you'll use it.

namespace :email do
  desc "Send a one-time email to all rsvp'd guests"
  task :send_info_to_guests, [:date] => :environment do |t, args|
    date = Date.parse(args.date)
    puts
    Party.where("created_at > ? AND rsvp = ?", date, true).find_each do |party|
      party.guests.where.not(email: [nil, ""]).each do |guest|
        puts "Sending to #{guest.name}..."

        GuestMailer.info_email(guest).deliver_now # last_run: 2024-02-22

        puts "Sent."
      end
    end
    puts
    puts "Done!"
  end
end
