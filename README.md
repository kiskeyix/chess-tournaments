Chess Tournaments
=================

A web application for managing chess tournaments. Organizers can sign in with an existing account (GitHub, Facebook, Google, Twitch) or create a local account, then quickly set up tournaments with players and teams. Supports individual tournaments and team-based play (e.g. teams of 4). Tournament formats include round-robin and Swiss-style pairings, chosen by the tournament creator. The creator becomes the tournament admin and can assign helpers to manage the event.

Requirements
============

* Ruby 4.0.2
* Rails 8.1.3
* SQLite3
* Bundler

Setup
=====

1. `source ruby.env` (sets PATH for Homebrew Ruby 4.0)
2. `bundle install`
3. `rake db:migrate`
4. Edit `config/initializers/devise.rb`
5. Set environment variables for OAuth providers and app secrets:
```
    CHESS_ADMIN_EMAIL

    GITHUB_APP_ID
    GITHUB_APP_SECRET
    FACEBOOK_APP_ID
    FACEBOOK_APP_SECRET
    GOOGLE_APP_ID
    GOOGLE_APP_SECRET
    TWITCH_APP_ID
    TWITCH_APP_SECRET

    SECRET_KEY_BASE
```
6. Edit the mailer domain in `config/environments/production.rb`

Developing/Hacking
==================

Creating a local admin account
------------------------------

1. Launch server: `rails s`
2. Choose "Create local account" from the drop-down menu
3. Verify your email by following the confirmation link from `log/development.log`, e.g.: `http://localhost:3000/users/confirmation?confirmation_token=SECRET_STRING`
4. Open the Rails console: `rails console`
5. Make your user an admin:
```ruby
u = User.last
u.admin = true
u.save
```

Player images
-------------
When creating players we default to images from Gravatar if the image link is not defined or left blank.

Current Features
================

**Authentication & Users**
- Local account creation with email confirmation
- OAuth sign-in via GitHub, Facebook, Google, Twitch
- Admin role for site-wide management
- User-to-player profile linking
- Account lockout after failed attempts
- Session timeout after inactivity

**Tournaments**
- Create, edit, and delete tournaments with start/end dates
- Configure boards per match for team play
- Tournaments automatically get a default division on creation
- Admin-only tournament management
- Associate tournaments with leagues

**Divisions & Rounds**
- Organize tournaments into divisions (team groupings) and rounds (time-based)
- Full CRUD for divisions and rounds within a tournament
- Date validation for rounds within tournament date range

**Teams & Players**
- Create and manage teams and player profiles
- Team captain system: promote/demote captains with permission checks
- Teams join tournaments by selecting divisions
- Add players to teams
- Player nationality and gender tracking
- Gravatar fallback for player images

**Matches**
- Create matches within rounds, assigning home and guest teams
- Match postponement tracking
- Admin-only match management

**Games**
- Record individual games with PGN and FEN data
- Interactive chess board visualization (chess.js + chessboard.js)
- Move navigation controls (first, last, next, previous, flip board)
- Clickable move list with highlighting
- Keyboard navigation (arrow keys)
- Link games to white/black players with ELO ratings

**Lineups**
- Lineup model linking teams to matches
- Lineup line items for individual board assignments
- Lineup optimization helper (best lineup by rating)

**Dashboard**
- Context-aware home page: shows open tournaments, past tournaments, and user's teams
- Different views for guests, players without teams, and team members
- Paginated listings

**Search**
- Full-text search across tournaments, teams, and players

**Leagues & Rules**
- Create leagues and attach rules to them
- Markdown rendering for rule bodies (Redcarpet)
- Admin-only management

**Messaging**
- Internal messaging system between users
- Read/unread message tracking
- Message badge in navigation bar

TODO
====

- [ ] **Round-robin pairing algorithm**: auto-generate matches so every team plays every other team
- [ ] **Swiss-style pairing algorithm**: pair teams by score each round
- [ ] **Tournament type selection**: choose format at creation time with automatic match generation
- [ ] **Lineup management UI**: interface for team captains to submit lineups before each round
- [ ] **PGN parsing and validation**: auto-generate FEN positions from PGN move lists
- [ ] **PGN import/export**: bulk import/export PGN files for games
- [ ] **Compose and send messages**: message compose form and reply functionality
- [ ] **Match result recording**: record and validate match results
- [ ] **Standings calculation**: automatic standings per division with tiebreak rules
- [ ] **Player ratings**: track ratings over time, rating-based seeding for Swiss pairings
- [ ] **Per-tournament admin delegation**: assign co-organizers per tournament (not just site-wide admin)
- [ ] **Migrate SCSS to CSS**: convert remaining `.scss` files for Propshaft compatibility or add `dartsass-rails`
- [ ] **Replace Bootstrap 3**: update to Bootstrap 5 or Tailwind CSS
- [ ] **Remove jQuery dependency**: migrate to Stimulus/Turbo for interactivity
- [ ] **Deploy configuration**: update deployment from Capistrano/Apache/Passenger to modern setup (Puma)
- [ ] **CI pipeline**: add GitHub Actions or similar for automated testing

Contributing
============

1. Fork on GitHub
2. Edit
3. Pull request
