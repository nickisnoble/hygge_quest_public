# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

guilds = [
  {
    name: "Athletica",
    description: "Champions in the relentless pursuit of excellence, we safeguard others through greatness in heart, mind, and body.",
    secret: false
  },
  {
    name: "Galanis",
    description: "Connectivity and influence is our currency, mastering the art of the network and charisma refined. We know everyone.",
    secret: false
  },
  {
    name: "Haven",
    description: "Our sancuary offers a solace from a changing world. We provide healing and comfort, nurturing all with wisdom and care.",
    secret: false
  },
  {
    name: "Myst",
    description: "Masters of the unknown, there is no machine nor manual that can keep knowedge hidden from the Myst.",
    secret: false
  },
  {
    name: "Reverie",
    description: "Keepers of stories, weavers of tales, we love a great time with friends and good cheer.",
    secret: false
  }
]

guilds.each do |guild_attributes|
  Guild.find_or_create_by!(guild_attributes)
end

Party.create!(
  name: "The Couple",
  rsvp: true,
  guests: [
    Guest.new({
      name: "Nick Noble",
      email: "groom@example.com",
      dungeon_master: true,
      guild_id: 4
    }),

    Guest.new({
      name: "Marnie Williams",
      email: "bride@example.com",
      dungeon_master: true,
      guild_id: 3
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
        dungeon_master: false,
        guild_id: 3
      }),

      Guest.new({
        name: "Ms Piggy",
        email: "moi@example.com",
        dungeon_master: false,
        guild_id: 2
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
        dungeon_master: false,
        guild_id: 4
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
        dungeon_master: false
      })
    ]
  )
end
