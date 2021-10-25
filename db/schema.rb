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

ActiveRecord::Schema.define(version: 2021_10_25_111234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "adherents", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "prenom"
    t.string "nom"
    t.string "telephone"
    t.string "adresse_postale"
    t.string "code_postale"
    t.string "ville"
    t.string "niveau_etude"
    t.string "annee_diplome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "specialisation_etude"
    t.string "file_status"
    t.index ["user_id"], name: "index_adherents_on_user_id"
  end

  create_table "config_doc_adherents", force: :cascade do |t|
    t.bigint "junior_configuration_id", null: false
    t.string "nom"
    t.boolean "obligatoire"
    t.string "duree_validite"
    t.string "format_duree_validite"
    t.boolean "archive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_configuration_id"], name: "index_config_doc_adherents_on_junior_configuration_id"
  end

  create_table "document_adherents", force: :cascade do |t|
    t.bigint "adherent_id", null: false
    t.string "nom"
    t.boolean "obligatoire"
    t.string "validite"
    t.boolean "archive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_debut_validite"
    t.string "raison_invalid"
    t.date "date_fin_validite"
    t.index ["adherent_id"], name: "index_document_adherents_on_adherent_id"
  end

  create_table "junior_configurations", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.text "niveau_etude", default: [], array: true
    t.text "specialisation_etude", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_id"], name: "index_junior_configurations_on_junior_id"
  end

  create_table "juniors", force: :cascade do |t|
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "codeje"
  end

  create_table "mandat_membres", force: :cascade do |t|
    t.bigint "membre_id", null: false
    t.bigint "pole_id", null: false
    t.bigint "poste_id", null: false
    t.date "annee_debut"
    t.date "annee_fin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["membre_id"], name: "index_mandat_membres_on_membre_id"
    t.index ["pole_id"], name: "index_mandat_membres_on_pole_id"
    t.index ["poste_id"], name: "index_mandat_membres_on_poste_id"
  end

  create_table "membre_requests", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.bigint "user_id", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_id"], name: "index_membre_requests_on_junior_id"
    t.index ["user_id"], name: "index_membre_requests_on_user_id"
  end

  create_table "membres", force: :cascade do |t|
    t.bigint "membre_request_id", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["membre_request_id"], name: "index_membres_on_membre_request_id"
  end

  create_table "permission_membres", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_id"], name: "index_permission_membres_on_junior_id"
  end

  create_table "permissions_membres", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.bigint "membre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_id"], name: "index_permissions_membres_on_junior_id"
    t.index ["membre_id"], name: "index_permissions_membres_on_membre_id"
  end

  create_table "poles", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "achive"
    t.index ["junior_id"], name: "index_poles_on_junior_id"
  end

  create_table "postes", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "achive"
    t.index ["junior_id"], name: "index_postes_on_junior_id"
  end

  create_table "userparams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "navbar_active", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_userparams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.boolean "admin", default: false
    t.bigint "junior_id", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["junior_id"], name: "index_users_on_junior_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adherents", "users"
  add_foreign_key "config_doc_adherents", "junior_configurations"
  add_foreign_key "document_adherents", "adherents"
  add_foreign_key "junior_configurations", "juniors"
  add_foreign_key "mandat_membres", "membres"
  add_foreign_key "mandat_membres", "poles"
  add_foreign_key "mandat_membres", "postes"
  add_foreign_key "membre_requests", "juniors"
  add_foreign_key "membre_requests", "users"
  add_foreign_key "membres", "membre_requests"
  add_foreign_key "permission_membres", "juniors"
  add_foreign_key "permissions_membres", "juniors"
  add_foreign_key "permissions_membres", "membres"
  add_foreign_key "poles", "juniors"
  add_foreign_key "postes", "juniors"
  add_foreign_key "userparams", "users"
  add_foreign_key "users", "juniors"
end
