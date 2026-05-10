# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Chess tournament management app. Users sign in via OAuth (GitHub, Facebook, Google, Twitch) or local accounts, then set up tournaments — individual or team-based (e.g. teams of 4). Supports round-robin and Swiss-style formats chosen at tournament creation. The tournament creator is the admin and can delegate to helpers. Built with Rails 8.1.3, Ruby 4.0.2, SQLite3.

Major areas not yet implemented: pairing algorithms (Swiss/round-robin), lineup management UI, PGN parsing, messaging compose/send, standings calculation, and per-tournament admin delegation. See README.md for the full TODO list.

## Common Commands

```bash
# Set up Ruby environment (must run first in each shell)
source ruby.env

# Run dev server
rails s

# Run all tests
rake test

# Run a single test file
ruby -Itest test/models/player_test.rb

# Database setup/migration
rake db:migrate

# Rails console
rails console

# View all routes
rake routes
```

## Architecture

### Domain Model

Tournament organization follows this hierarchy:
**League > Tournament > Division/Round > Match > Lineup > Game**

Key relationships:
- A **Tournament** has many **Divisions** (groupings of teams) and **Rounds** (time-based)
- A **Round** has many **Matches**; each Match has a `home_team` and `guest_team`
- A **Match** has **Lineups** (one per team), which contain **LineupsLineItems**
- A **Game** stores PGN data, linked to `white_player` and `black_player`
- **Teams** and **Players** use HABTM join tables (not has_many :through)
- **Players** are linked to **Users** via `belongs_to :user`
- Team captaincy is modeled through the **TeamCaptain** join model
- All models inherit from **ApplicationRecord** (Rails 8 convention)

### Authentication

- Devise 5.0 with `username` as the authentication key (not email)
- OAuth via `omniauth-github`, `omniauth-facebook`, `omniauth-google-oauth2`, `omniauth-twitch`
- OAuth identities stored in the **Identity** model, linked to users
- Admin access is a boolean flag on the User model
- Local dev admin setup: sign up, confirm via log, then `User.last.update(admin: true)` in console

### Routing

Routes use `shallow: true` nesting. Tournaments nest divisions and rounds; rounds nest matches; matches nest lineups. Teams have custom member routes for captain management and division/player joining.

### Frontend

Bootstrap 3 (legacy, needs migration), jQuery UI. Markdown rendering via Redcarpet. Pagination via `will_paginate`. Asset pipeline uses Propshaft. SCSS files exist but are not compiled (needs `dartsass-rails` or conversion to plain CSS).

### Environment Variables (Production)

OAuth credentials (`GITHUB_APP_ID/SECRET`, `FACEBOOK_APP_ID/SECRET`, `GOOGLE_APP_ID/SECRET`, `TWITCH_APP_ID/SECRET`), `CHESS_ADMIN_EMAIL`, `SECRET_KEY_BASE`.

## Testing

Uses minitest with `minitest-spec-rails` for BDD-style (`it` blocks) and `rails-controller-testing` for `assigns()` support. Fixtures in `test/fixtures/` for all models. Controller tests use `params: {}` keyword args (Rails 5+ style). No CI pipeline configured.
