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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151123113058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approvals", force: :cascade do |t|
    t.integer  "status"
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "major_version"
    t.integer  "minor_version"
  end

  create_table "audit_approvals", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "audit_id"
    t.integer  "user_id"
  end

  add_index "audit_approvals", ["audit_id"], name: "index_audit_approvals_on_audit_id", using: :btree
  add_index "audit_approvals", ["user_id"], name: "index_audit_approvals_on_user_id", using: :btree

  create_table "audit_reviews", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "audit_id"
    t.integer  "user_id"
  end

  add_index "audit_reviews", ["audit_id"], name: "index_audit_reviews_on_audit_id", using: :btree
  add_index "audit_reviews", ["user_id"], name: "index_audit_reviews_on_user_id", using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "status"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id"
    t.integer  "user_id"
    t.integer  "risk_id"
  end

  add_index "audits", ["risk_id"], name: "index_audits_on_risk_id", using: :btree
  add_index "audits", ["topic_id"], name: "index_audits_on_topic_id", using: :btree
  add_index "audits", ["user_id"], name: "index_audits_on_user_id", using: :btree

  create_table "audits_practices", force: :cascade do |t|
    t.integer  "result"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "audit_id"
    t.string   "observation"
    t.string   "evidence"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "audits_practices", ["audit_id"], name: "index_audits_practices_on_audit_id", using: :btree

  create_table "audits_practices_actions", force: :cascade do |t|
    t.string   "action"
    t.integer  "status"
    t.string   "comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.integer  "audits_practice_id"
  end

  add_index "audits_practices_actions", ["audits_practice_id"], name: "index_audits_practices_actions_on_audits_practice_id", using: :btree
  add_index "audits_practices_actions", ["user_id"], name: "index_audits_practices_actions_on_user_id", using: :btree

  create_table "audits_practices_documents", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "audits_practice_id"
    t.integer  "document_id"
    t.integer  "major_version"
  end

  add_index "audits_practices_documents", ["audits_practice_id"], name: "index_audits_practices_documents_on_audits_practice_id", using: :btree
  add_index "audits_practices_documents", ["document_id"], name: "index_audits_practices_documents_on_document_id", using: :btree

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                     null: false
    t.text     "body",                          null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   default: 0
    t.integer  "cached_votes_down", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", null: false
    t.integer  "subscriber_id",   null: false
    t.integer  "thread_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "document_revisions", force: :cascade do |t|
    t.integer  "major_version"
    t.integer  "minor_version"
    t.string   "content"
    t.string   "change_control"
    t.integer  "document_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "document_revisions", ["document_id"], name: "index_document_revisions_on_document_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.integer  "status"
    t.string   "content"
    t.boolean  "assigned_to_all"
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.integer  "document_type_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.string   "major_version"
    t.string   "minor_version"
    t.boolean  "do_update"
    t.string   "change_control"
    t.date     "review_date"
    t.integer  "document_topic_id"
    t.integer  "topic_id"
  end

  add_index "documents", ["topic_id"], name: "index_documents_on_topic_id", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "organisation_services", force: :cascade do |t|
    t.integer  "organisation_id"
    t.integer  "service_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organisation_services", ["organisation_id"], name: "index_organisation_services_on_organisation_id", using: :btree
  add_index "organisation_services", ["service_id"], name: "index_organisation_services_on_service_id", using: :btree

  create_table "organisation_users", force: :cascade do |t|
    t.boolean  "accepted"
    t.integer  "user_type"
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "inviter_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "gms_code"
  end

  create_table "pending_users", force: :cascade do |t|
    t.string   "email"
    t.string   "user_type"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "inviter_id"
    t.integer  "pending_type"
  end

  create_table "readers", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "readers", ["document_id"], name: "index_readers_on_document_id", using: :btree
  add_index "readers", ["user_id"], name: "index_readers_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "status"
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "major_version"
    t.integer  "minor_version"
  end

  create_table "risks", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "score"
    t.string   "desc"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "status"
    t.integer  "topic_id"
  end

  add_index "risks", ["organization_id"], name: "index_risks_on_organization_id", using: :btree
  add_index "risks", ["topic_id"], name: "index_risks_on_topic_id", using: :btree
  add_index "risks", ["user_id"], name: "index_risks_on_user_id", using: :btree

  create_table "risks_details", force: :cascade do |t|
    t.string   "title"
    t.integer  "impact"
    t.integer  "likelihood"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "risk_id"
  end

  add_index "risks_details", ["risk_id"], name: "index_risks_details_on_risk_id", using: :btree

  create_table "risks_impacts", force: :cascade do |t|
    t.string   "name"
    t.string   "impact"
    t.string   "description"
    t.integer  "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "enabled"
    t.integer  "sequence"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sops", force: :cascade do |t|
    t.string   "title"
    t.integer  "services_id"
    t.string   "content"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.string   "major_version"
    t.string   "minor_version"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "sops", ["services_id"], name: "index_sops_on_services_id", using: :btree

  create_table "topic_services", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topic_services", ["service_id"], name: "index_topic_services_on_service_id", using: :btree
  add_index "topic_services", ["topic_id"], name: "index_topic_services_on_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organisation_id"
    t.integer  "score"
    t.datetime "last_audit_date"
  end

  add_index "topics", ["organisation_id"], name: "index_topics_on_organisation_id", using: :btree

  create_table "trainees", force: :cascade do |t|
    t.integer  "status"
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "major_version"
    t.integer  "minor_version"
  end

  create_table "users", force: :cascade do |t|
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_seen_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
