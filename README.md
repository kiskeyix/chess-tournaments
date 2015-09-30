Chess::Tournaments
==================

A chess tournament tracking application

Setup
=====

1. edit config/initializers/devise.rb
2. setup your apache configuration with ENV variables for:
```
    CHESS_ADMIN_EMAIL

    GITHUB_APP_ID
    GITHUB_APP_SECRET
    TWITTER_APP_ID
    TWITTER_APP_SECRET
    FACEBOOK_APP_ID
    FACEBOOK_APP_SECRET
    GPLUS_APP_ID
    GPLUS_APP_SECRET
    TWITCH_APP_ID
    TWITCH_APP_SECRET

    SECRET_KEY_BASE
```
3. edit the mailer domain in config/environments/production.rb
4. if using Capistrano to deploy your app, your path will be /srv/web/apps/chess-tournaments/current/public

Contributing
============

1. fork on github
2. edit
3. pull request
