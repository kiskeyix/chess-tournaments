# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2016_04_16_015459) do
  create_table "divisions", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.integer "tournament_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "divisions_teams", id: false, force: :cascade do |t|
    t.integer "division_id", null: false
    t.integer "team_id", null: false
    t.index ["division_id", "team_id"], name: "index_divisions_teams_on_division_id_and_team_id"
    t.index ["team_id", "division_id"], name: "index_divisions_teams_on_team_id_and_division_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "black_elo"
    t.integer "black_player_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "date", precision: nil
    t.integer "division_id"
    t.string "event"
    t.string "fen"
    t.string "name"
    t.text "pgn"
    t.string "result"
    t.string "site"
    t.string "timecontrol"
    t.datetime "updated_at", precision: nil, null: false
    t.string "visibility"
    t.string "white_elo"
    t.integer "white_player_id"
    t.index ["event"], name: "index_games_on_event"
    t.index ["name"], name: "index_games_on_name"
  end

  create_table "games_lineups_line_items", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "lineups_line_item_id", null: false
  end

  create_table "games_players", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "player_id", null: false
    t.index ["game_id", "player_id"], name: "index_games_players_on_game_id_and_player_id"
    t.index ["player_id", "game_id"], name: "index_games_players_on_player_id_and_game_id"
  end

  create_table "identities", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "leagues_rules", id: false, force: :cascade do |t|
    t.integer "league_id", null: false
    t.integer "rule_id", null: false
    t.index ["league_id", "rule_id"], name: "index_leagues_rules_on_league_id_and_rule_id"
    t.index ["rule_id", "league_id"], name: "index_leagues_rules_on_rule_id_and_league_id"
  end

  create_table "lineups", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "match_id"
    t.integer "team_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "lineups_line_items", force: :cascade do |t|
    t.boolean "alternate"
    t.integer "board_number"
    t.datetime "created_at", precision: nil, null: false
    t.integer "lineup_id"
    t.integer "player_id"
    t.boolean "rating_only"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.integer "guest_team_id"
    t.integer "guest_team_lineup_id"
    t.integer "home_team_id"
    t.integer "home_team_lineup_id"
    t.text "location"
    t.string "name"
    t.datetime "postponed_date", precision: nil
    t.integer "result_id"
    t.integer "round_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["guest_team_id"], name: "index_matches_on_guest_team_id"
    t.index ["guest_team_lineup_id"], name: "index_matches_on_guest_team_lineup_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["name"], name: "index_matches_on_name"
    t.index ["round_id"], name: "index_matches_on_round_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "sent", precision: nil
    t.string "subject"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "messages_users", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "message_id"
    t.boolean "read", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["message_id"], name: "index_messages_users_on_message_id"
    t.index ["read"], name: "index_messages_users_on_read"
    t.index ["user_id"], name: "index_messages_users_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "gender"
    t.string "image"
    t.string "name"
    t.string "nationality"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
  end

  create_table "players_teams", id: false, force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.index ["player_id", "team_id"], name: "index_players_teams_on_player_id_and_team_id"
    t.index ["team_id", "player_id"], name: "index_players_teams_on_team_id_and_player_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.datetime "end_date", precision: nil
    t.string "name"
    t.datetime "start_date", precision: nil
    t.integer "tournament_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_rounds_on_name"
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "rules", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.text "summary"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_rules_on_name"
  end

  create_table "team_captains", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "player_id"
    t.integer "team_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.integer "boards_per_match", default: 4
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.datetime "end_date", precision: nil
    t.string "image"
    t.integer "league_id"
    t.string "name"
    t.datetime "start_date", precision: nil
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "admin", default: false
    t.string "birthday", default: "", null: false
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "firstname", default: "", null: false
    t.string "gender", default: "", null: false
    t.string "image", default: "", null: false
    t.datetime "last_sign_in_at", precision: nil
    t.string "last_sign_in_ip"
    t.string "lastname", default: "", null: false
    t.datetime "locked_at", precision: nil
    t.string "middlename", default: "", null: false
    t.string "nickname", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.string "surname", default: "", null: false
    t.string "time_zone", default: "Eastern Time (US & Canada)"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username", default: "", null: false
    t.index ["active"], name: "index_users_on_active"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end
end
