# README

This is a time capsule of the app I made for my wedding in 2024.

![onboarding](https://github.com/user-attachments/assets/a111ff74-2cde-4c6a-805a-a476f46fbae7)



### I built it because:

1. Most wedding website builders suck, and none of them had the features I wanted.
2. It was a themed wedding, and the RSVP flow was the first impression of it guests would see.
3. I wanted to.

There's more on each point below, but that's the gist. But first...

> [!WARNING]
> ### There be dragons here
>
> This was made by a nerd, for a nerdy wedding.
>
> It has no intention of being a polished product, nor even a "good" one, past what it was made for – because it was always intended to be short lived. 
>
> There are minimal tests, the code is often [strange](https://github.com/nickisnoble/hygge_quest_public/blob/41d8ecc0b4a52a8232d601111f67dc5afa103fd8/app/controllers/concerns/dungeon_master/cerberus.rb#L1-L9) or hastily written, and 99% of the content is written in HTML.
>
> But in the end, it ended up being useful, and unique. I really like how it looked and worked, and showing it to people, they say it could be quite useful to others.
>
> #### I'm sharing it with you for three reasons:
>
> 1. I want to show it off, even the rough bits!
> 2. In case it's useful for your own nerdy wedding. Feel free to use it as a base, and *expect* to rip out the parts you don't need.
> 3. To demonstrate that homecooked software can be useful, even if it's just for your friends and family, and just for a short time.


# Design & functionality

Our wedding was fantasy TTRPG themed. Think Dungeons & Dragons, The Princess Bride, Game of Thrones, Zelda. We also wanted everyone to dress up and feel like they were part of our story.

Many of our guests were familiar, but some we knew would feel a little like fish out of water. We wanted to recreate and share some of the magic of playing these games (which is how we met) for people who maybe never played, and make our guests feel welcome.

So this site was a way to get the information we needed, but also start seeding "the vibes" early on.

### Guilds

So in addition to the normal RSVP stuff, like food preferences, we asked people to choose a "guild".

This is somewhere between a D&D class, a Hogwarts house, or an Astrological sign – something anyone can grok immeditiately, feels somewhat authentic to themselves, but gives the feeling of being part of a larger fantasy world.

Guilds also helped with clothing, since we asked people to dress up – for folks who'd never been to renn faires or comic cons, this was a way of helping them not have to start from scratch.

You'll see in the app that there's apparatus for "looks" aka inspiration we pulled / generated for various fashion ideas, matching the colors and themes of each guild. It wasn't a costume party per se, we just wanted to do something different than regular suits and dresses.

![Guild-edit](https://github.com/user-attachments/assets/48bb172b-ce44-4f25-8ee9-02b3b225d6b2)


### Parties

> [!NOTE]
> The big thing I found lacking in almost all wedding websites is a way to manage one's group of guests.
>
> #### What we found was some combination of:
>
> - A guest list that's just a list, like a spreadsheet, but in a shitty CMS, and you can't control the fields.
> - As a guest, you put in your own name, but everyone else is listed as "plus one" or "guest", and details like allergies need to be stuffed awkwardly into one text field.
> - Every guest needs to have a login (because evil data extraction), and enter their own data, one person can't simply RSVP for their family.
> - If you want to decline the RSVP, you have to enter a ton of info anyways.
>
> And even worse, most of these services (like Zola, etc) are designed to extract and sell not just your data, but your guests' data, to marketers. I wasn't interested in selling my guests personal info for the sake of having a "free" wedding website, with inferior features, and a basic bitch aesthetic.

For most people, when they get an RSVP in the mail, there's someone in the family who's the calendar keeper, and they want to just handle it! They know their kid can't eat gluten, the other is away at college and can't make it, and their spouse wants the steak, not the chicken.

![party](https://github.com/user-attachments/assets/3bc29536-940c-4f2a-aaa3-7fcf130b0be0)


#### So our app works like that:

1. One person can RSVP for their entire party, and it happens automatically (a party is created for them on the initial RSVP).
2. If they RSVP yes (for the group), they make their own choices with a large UI, so that they get very familiar with the options. Then they can add everyone else with a quick entry UI, and anyone with an email address in the system now can login themselves and make changes later if they want. [^1]
4. If they RSVP no (for the group), we know who they are and can infer their family isn't going. They get a field to leave a note, that's it, no need to enter everyone else.

[^1]: Children under 13 don't have an email field.

Everything on that page autosaves, and if someone tries to RSVP again, it just redirects them to the step they were on.

## Actual Features

- Automagic login. No inital sign-up, "it just works."
- Not every guest needs to have a login. Party members can manage other members of the same party.
- Staggered deadlines for waves of RSVPs, automatically locks changes for parties at deadline.
- Private and shared notes for hosts for each party and guest.
- Email broadcast system for hosts to send to guests, in part or in whole.
- Admin view including crud for guests, the ability to send said emails, and basic stats, eg total guests, breakdown by attending, total count of each meal option, etc.
- Map view, automatically drops markers based on address (uses geocoder to get lat/lng).

![Screenshot — Arc  Arc  — 2024-04-29  0446PM](https://github.com/user-attachments/assets/1456ad5a-07ed-4c2f-83f6-31393387662e)


### Unimplemented
These were features I wanted to add, but didn't have time to finish before the wedding:
- A "quest" system for guests to complete before the wedding, allowing them to earn XP and achievements. (Sort of a fun way to identify things to do in Baltimore for guests arriving early, or sightseeing in the area). This was simplified to just a map view, with a few locations marked.
- A full PWA experience, with photo modes, etc. (You *can* install the app, but all it is currently is a custom icon and caching.)

![Screenshot — Arc  Arc  — 2024-04-05  0403PM](https://github.com/user-attachments/assets/bd5ecb60-981c-4283-bcb0-b8a226e65958)


> [!CAUTION]
> ## A note on images and licensing
>
> Most of the images on the site were generated with AI, and I'm not sure what license they're under. If you use this site as a template for your own, you should replace them!
>
> - **Background images** were generated with Dalle, using a [custom GPT](https://chatgpt.com/g/g-bb0WtJcAD-botanical-fantasy-creator) for consistency. (Feel free to use it if you'd like!)
> - **Fashion / character images** on the guild pages were mostly generated with [Lexica](https://lexica.art/).
> - Open Graph images were made using a combination of the above and Figma.
>

## **The lantern / seal is not free to use, nor is it included under any license with the software. That is ours!**

<div style="display: flex; gap: 24px; height: 100px;"><img style="max-height: 64px; width: auto;" src="https://github.com/user-attachments/assets/d2455ac4-9423-457e-8273-c5a77ce6931f" alt="seal" /><img style="max-height: 64px; width: auto;" src="https://github.com/user-attachments/assets/1262a915-44e9-4fdc-92a0-a59650e589dc" alt="seal-wax" /></div>


---

# Technical Notes

This is a Rails app, with this general stack:
- Rails 7.1
- SQLite for database (see below for why!)
- TailwindCSS for styling
- Hotwire / Turbo / Stimulus for frontend interactivity
- ActiveStorage + S3 for file uploads (minimal)
- Resend for email
- Passwordless for login
- Leaflet for mapping, FontAwesome for icons, both client-side only
- Render for hosting

### SQLite?!

This is the nice thing about a wedding app: you know exactly how many guests you have, and the days when you'll have the most traffic. At maximum, this app had 120 users (though many fewer on any given day, and not everyone responds when you send out RSVPs).

SQLite is fast and easy, but better yet, it's a file that I can archive – a perfect time capsule for the data from our wedding.

## Running the app

### Locally
1. Clone the repo
2. `$ bundle install`
3. `$ bundle exec rails db:migrate`
4. `$ bundle exec rails db:seed` (You'll want to adjust the seed data to make you and your partner the hosts)
5. `$ ./bin/dev`

### On Render.com

1. Push the repo to github
2. Configure a render project for it
3. Set the environment variables (see `.env.example`)
4. Add a disk for sqlite *(see SQLite note above and start command below. This creates some limitations around deploys, but it's way cheaper than a Postgres instance)*
5. Deploy via push!

> [!WARNING]
> **This is from memory**
> So it may not be exactly right, consult the render docs or get in touch if you need help.

#### Settings

- **Build Command**: `$ bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean;`
- **Start Command**: `$ bundle exec rails db:migrate; bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-production}`

Note migration done on *start* is weird, usually you'd do it at build. But since this app uses SQLite, which is literally a file on the disk, it's not accessible until it boots.
