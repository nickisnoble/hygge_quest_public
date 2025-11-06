# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding database..."

# Set up basic configuration
Configuration.set("site_title", "Wedding RSVP") unless Configuration.find_by(key: "site_title")
puts "✓ Configuration set"

# Create sample groups
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

puts "✓ Created #{Group.count} groups"

# Create admin users (only if they don't exist)
unless Guest.exists?(email: "groom@example.com")
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
end

if Rails.env.development?
  # Create sample parties for testing
  unless Guest.exists?(email: "frog@example.com")
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
  end

  unless Guest.exists?(email: "gg@example.com")
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
  end

  unless Guest.exists?(email: "wakawaka@example.com")
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
  end
end

puts "✓ Created #{Guest.count} guests in #{Party.count} parties"

# Create sample pages
registry_page = Page.find_or_create_by!(slug: "registry") do |page|
  page.title = "Gift Registry"
  page.published = true
end

if registry_page.content.body.blank?
  registry_page.update(content: <<~HTML
    <h2>Gift Registry</h2>
    <p>Your presence at our wedding is the greatest gift of all. If you wish to honor us with a gift, we have registered at the following locations:</p>

    <h3>Registry Options</h3>
    <ul>
      <li><strong>Honeymoon Fund:</strong> Contributions toward our honeymoon adventure</li>
      <li><strong>Home Fund:</strong> Help us build our home together</li>
      <li><strong>Traditional Registry:</strong> [Add your registry links here]</li>
    </ul>

    <p>Thank you for your love and support!</p>
  HTML
  )
end

if Rails.env.development?
  travel_page = Page.find_or_create_by!(slug: "travel") do |page|
    page.title = "Travel & Accommodations"
    page.published = true
  end

  if travel_page.content.body.blank?
    travel_page.update(content: <<~HTML
      <h2>Travel & Accommodations</h2>
      <p>We're so excited to celebrate with you! Here's some helpful information for your visit.</p>

      <h3>Venue Address</h3>
      <p>[Add ceremony venue address here]</p>

      <h3>Recommended Hotels</h3>
      <ul>
        <li><strong>Hotel Name:</strong> [Address and booking info]</li>
        <li><strong>Hotel Name:</strong> [Address and booking info]</li>
      </ul>

      <h3>Getting There</h3>
      <p>[Add transportation information - nearest airport, parking details, etc.]</p>
    HTML
    )
  end

  schedule_page = Page.find_or_create_by!(slug: "schedule") do |page|
    page.title = "Wedding Schedule"
    page.published = true
  end

  if schedule_page.content.body.blank?
    schedule_page.update(content: <<~HTML
      <h2>Wedding Day Schedule</h2>
      <p>Here's what to expect on our special day!</p>

      <h3>Ceremony</h3>
      <p><strong>Time:</strong> [Add time]<br>
      <strong>Location:</strong> [Add location]</p>

      <h3>Cocktail Hour</h3>
      <p><strong>Time:</strong> [Add time]<br>
      <strong>Location:</strong> [Add location]</p>

      <h3>Reception</h3>
      <p><strong>Time:</strong> [Add time]<br>
      <strong>Location:</strong> [Add location]</p>

      <h3>Attire</h3>
      <p>[Add dress code information]</p>
    HTML
    )
  end
end

puts "✓ Created #{Page.count} pages"
puts "Database seeding complete!"
