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

Developing/Hacking
==================

These are a few considerations to keep in mind when working in `RAILS_ENV=development`.

Creating a local admin account
------------------------------

1. launch server: `rails s`
2. choose "Create local account" from drop-down menu
3. verify your email following the user from log/development.log. i.e.: `http://localhost:3000/users/confirmation?confirmation_token=SECRET_STRING`
4. using the terminal, go into the Rails Console: `rails console`
5. select the user you created and made it admin
```
u = User.last
u.admin
u.save
```


Contributing
============

1. fork on github
2. edit
3. pull request
