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

ActiveRecord::Schema.define(:version => 20120429145424) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.string   "description"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interest_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.integer  "interest_type_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaves", :force => true do |t|
    t.datetime "schedule_date"
    t.integer  "leave_type_id"
    t.string   "reason"
    t.boolean  "is_submitted"
    t.boolean  "is_approved"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "username"
    t.string   "password"
    t.boolean  "active",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "department_id"
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "person_times", :force => true do |t|
    t.integer  "person_id"
    t.integer  "activity_id"
    t.time     "start_time"
    t.time     "end_time"
    t.time     "total_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_submitted"
    t.boolean  "is_approved"
    t.integer  "role_id"
    t.integer  "updated_by"
    t.integer  "approved_by"
    t.integer  "is_overtime",          :limit => 1
    t.integer  "specific_activity_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specific_activities", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
    t.string   "description"
  end

end
