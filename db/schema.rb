# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121206015618) do

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "convocations", :force => true do |t|
    t.boolean  "called"
    t.boolean  "initial"
    t.boolean  "bench"
    t.integer  "player_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "convocations", ["game_id", "player_id"], :name => "index_convocations_on_game_id_and_player_id", :unique => true

  create_table "events", :force => true do |t|
    t.integer  "code"
    t.integer  "minute"
    t.integer  "game_id"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "events", ["game_id"], :name => "index_events_on_game_id"

  create_table "games", :force => true do |t|
    t.string   "opponent"
    t.date     "date"
    t.time     "hour"
    t.boolean  "at_home"
    t.boolean  "played"
    t.boolean  "lineup_selected"
    t.integer  "team_id"
    t.integer  "goals_scored"
    t.integer  "goals_suffered"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "games", ["team_id"], :name => "index_games_on_team_id"

  create_table "injuries", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "can_play"
    t.boolean  "active"
    t.text     "description"
    t.integer  "player_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "injuries", ["player_id"], :name => "index_injuries_on_player_id"

  create_table "players", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.decimal  "height"
    t.date     "date_of_birth"
    t.string   "nationality"
    t.decimal  "weight"
    t.string   "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "players_teams", :id => false, :force => true do |t|
    t.integer "player_id"
    t.integer "team_id"
  end

  create_table "practices", :force => true do |t|
    t.date     "date"
    t.time     "hour"
    t.boolean  "presences_checked"
    t.integer  "team_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "practices", ["team_id"], :name => "index_practices_on_team_id"

  create_table "presences", :force => true do |t|
    t.boolean  "present"
    t.integer  "player_id"
    t.integer  "practice_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "presences", ["practice_id", "player_id"], :name => "index_presences_on_practice_id_and_player_id", :unique => true

  create_table "roles", :force => true do |t|
    t.boolean  "is_admin"
    t.boolean  "is_doctor"
    t.boolean  "is_coach"
    t.boolean  "is_manager"
    t.integer  "user_id"
    t.integer  "club_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["club_id"], :name => "index_roles_on_club_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "teams", :force => true do |t|
    t.string   "season"
    t.string   "name"
    t.integer  "club_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teams", ["club_id"], :name => "index_teams_on_club_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
