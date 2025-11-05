# Wedding RSVP Platform

A clean, modern Rails application for managing wedding RSVPs and guest communications.

## Features

### Guest-Facing
- **Passwordless Authentication** - No signup required, guests login via email link
- **Party Management** - One person can RSVP for their entire group
- **Meal Selection** - Visual meal preference selection with images
- **Flexible RSVP Flow** - Different flows for accepting vs. declining
- **Auto-Save** - All changes save automatically
- **Staggered Deadlines** - Automatically locks changes at response deadline
- **Dynamic Pages** - Content pages (registry, travel info) managed through admin

### Admin Features
- **Guest List Management** - Full CRUD for guests and parties
- **Email Broadcasting** - Send emails to individuals or entire groups
- **Group Organization** - Organize guests into groups (family, wedding party, etc.)
- **Statistics Dashboard** - View RSVPs, meal counts, and guest breakdown
- **Page Management** - Create and edit content pages without code changes
- **Location Management** - Add locations with automatic map markers
- **CSV Export** - Download guest list with all details

## Tech Stack

- **Rails 7.1** with Ruby 3.2.2
- **SQLite** - Perfect for wedding-sized datasets, easy to archive
- **Tailwind CSS** - Clean, modern styling with system fonts
- **Hotwire/Turbo/Stimulus** - Modern JavaScript for dynamic interactions
- **ActionText** - Rich text editing for pages and emails
- **Active Storage + S3** - File uploads for food images
- **Resend** - Transactional email delivery
- **Passwordless** - Email-based authentication
- **Geocoder** - Location mapping via OpenStreetMap

## Getting Started

### Local Development

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Set up the database:
   ```bash
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```
4. Start the development server:
   ```bash
   ./bin/dev
   ```

### Configuration

Copy `.env.example` to `.env` and configure:

```env
HOSTNAME=yoursite.com
DEFAULT_FROM_EMAIL=couple@yoursite.com
RESEND_API_KEY=your_resend_api_key
```

### Deployment

This application is designed to run on Render.com with SQLite:

1. Push to GitHub
2. Create a new Web Service on Render
3. Configure environment variables
4. Add a disk for SQLite storage
5. Use these build/start commands:

**Build Command:**
```bash
bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean;
```

**Start Command:**
```bash
bundle exec rails db:migrate; bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-production}
```

Note: Migrations run on start (not build) because SQLite file isn't available until the disk mounts.

## Customization

### Seed Data

Update `db/seeds.rb` with your details:
- Change couple names and emails
- Update group names (Wedding Party, Family, Friends, etc.)
- Customize the registry page content

### Branding

- Update `app/views/parties/new.html.erb` with your names and date
- Replace food images in `app/assets/images/food/`
- Update favicon and app icon
- Create custom Open Graph images for social sharing

### Pages

Admins can create custom pages through the admin panel:
1. Log in as an admin
2. Go to Admin Dashboard → Pages
3. Create pages for: registry, travel info, accommodations, schedule, etc.
4. Pages are accessible at `yoursite.com/page-slug`

## Architecture Decisions

### Why SQLite?

For a wedding app with ~100-200 guests:
- Fast and simple
- Zero operational overhead
- Easy to backup and archive
- Perfect for time-limited applications

### Party-Based RSVPs

Rather than individual RSVPs:
- One person manages their entire group
- Reduces friction (matches how people actually RSVP)
- Optional individual logins for party members
- Notes and preferences handled together

### Groups (Admin Only)

Groups help organize guests but aren't visible publicly:
- Useful for seating arrangements
- Email targeting (send to "Wedding Party" or "Out of town guests")
- Not part of guest experience

## Development Notes

### Rails Conventions

- Domain logic lives in models
- Controllers are thin
- No service objects unless truly needed
- 37signals-style PORO when appropriate

### Styling

- System fonts (serif for elegance, sans-serif for UI)
- Tailwind utility classes
- Minimal custom CSS
- Clean, professional design
- Easy to customize colors and typography

## License

This code is provided for personal use only. You may:
- Use it for your own wedding or a friend's wedding
- Learn from and modify the code
- Host it for personal events

You may NOT:
- Create a commercial product from this code
- Sell this as a service
- Redistribute without permission

**Images**: Replace all food images and assets with your own. The included images are examples only.

## Credits

Originally created as a fantasy-themed wedding app, refactored into a generic platform suitable for any wedding.

Built with ❤️ using Rails.
