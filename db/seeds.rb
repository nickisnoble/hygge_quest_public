# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

groups = [
  {
    name: "Wedding Party",
    description: "Members of the wedding party"
  },
  {
    name: "Family",
    description: "Family members"
  },
  {
    name: "Friends",
    description: "Friends of the couple"
  }
]

groups.each do |group_attributes|
  Group.find_or_create_by!(name: group_attributes[:name]) do |group|
    group.description = group_attributes[:description]
  end
end

Party.create!(
  name: "The Couple",
  rsvp: true,
  guests: [
    Guest.new({
      name: "Nick Noble",
      email: "groom@example.com",
      admin: true
    }),

    Guest.new({
      name: "Marnie Williams",
      email: "bride@example.com",
      admin: true
    })
  ]
)

if Rails.env.development?
  Party.create!(
    name: "The Framily",
    rsvp: true,
    guests: [
      Guest.new({
        name: "Kermit",
        email: "frog@example.com",
        admin: false
      }),

      Guest.new({
        name: "Ms Piggy",
        email: "moi@example.com",
        admin: false
      })
    ]
  )

  Party.create!(
    name: "The Solo",
    rsvp: true,
    guests: [
      Guest.new({
        name: "Gonzo",
        email: "gg@example.com",
        admin: false
      })
    ]
  )

  Party.create!(
    name: "Forgetful",
    rsvp: false,
    guests: [
      Guest.new({
        name: "Fozzy",
        email: "wakawaka@example.com",
        admin: false
      })
    ]
  )

  # Create sample registry page
  Page.find_or_create_by!(slug: "registry") do |page|
    page.title = "Registry"
    page.published = true
    page.content = <<~HTML
      <h2>What We Want Most</h2>
      <p>Your presence and support in our lives is the greatest gift we could ever hope for.</p>
      <p>If you'd like to contribute to our future together, we've set up options that will help us build our life as a married couple.</p>
      <h3>Honeymoon Fund</h3>
      <p>We're planning an amazing honeymoon and would love your help making it extra special.</p>
      <h3>Home Fund</h3>
      <p>We're saving for our first home together and every contribution helps us reach that goal.</p>
      <p><strong>Thank you for being part of our journey!</strong></p>
    HTML
  end
end
