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

ActiveRecord::Schema.define(version: 2022_02_20_215515) do

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

  create_table "clients", force: :cascade do |t|
    t.bigint "junior_id", null: false
    t.string "sexe"
    t.string "langue"
    t.string "prenom"
    t.string "nom"
    t.string "email"
    t.string "telephone"
    t.string "entreprise"
    t.string "poste"
    t.string "site_web"
    t.string "telephone_entreprise"
    t.string "siret"
    t.string "type_entreprise"
    t.string "activite"
    t.string "adresse"
    t.string "ville"
    t.string "code_postal"
    t.string "pays"
    t.string "provenance"
    t.string "premier_contact"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_id"], name: "index_clients_on_junior_id"
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

  create_table "etapes", force: :cascade do |t|
    t.bigint "etude_id", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["etude_id"], name: "index_etapes_on_etude_id"
  end

  create_table "etudes", force: :cascade do |t|
    t.bigint "prestation_id", null: false
    t.bigint "charge_etude_id"
    t.bigint "charge_qualite_id"
    t.bigint "charge_rh_id"
    t.string "statut"
    t.date "date_debut"
    t.integer "ref_etude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_signature"
    t.string "nom"
    t.boolean "confidentielle", default: false
    t.bigint "client_id"
    t.bigint "junior_id", null: false
    t.index ["charge_etude_id"], name: "index_etudes_on_charge_etude_id"
    t.index ["charge_qualite_id"], name: "index_etudes_on_charge_qualite_id"
    t.index ["charge_rh_id"], name: "index_etudes_on_charge_rh_id"
    t.index ["client_id"], name: "index_etudes_on_client_id"
    t.index ["junior_id"], name: "index_etudes_on_junior_id"
    t.index ["prestation_id"], name: "index_etudes_on_prestation_id"
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

  create_table "mandat_requests", force: :cascade do |t|
    t.bigint "poste_id", null: false
    t.bigint "pole_id", null: false
    t.bigint "membre_id", null: false
    t.date "date_debut"
    t.date "date_fin"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["membre_id"], name: "index_mandat_requests_on_membre_id"
    t.index ["pole_id"], name: "index_mandat_requests_on_pole_id"
    t.index ["poste_id"], name: "index_mandat_requests_on_poste_id"
  end

  create_table "mandats", force: :cascade do |t|
    t.bigint "mandat_request_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mandat_request_id"], name: "index_mandats_on_mandat_request_id"
    t.index ["permission_id"], name: "index_mandats_on_permission_id"
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

  create_table "permissions", force: :cascade do |t|
    t.bigint "junior_configuration_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_configuration_id"], name: "index_permissions_on_junior_configuration_id"
  end

  create_table "phases", force: :cascade do |t|
    t.bigint "etape_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["etape_id"], name: "index_phases_on_etape_id"
  end

  create_table "poles", force: :cascade do |t|
    t.bigint "junior_configuration_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_configuration_id"], name: "index_poles_on_junior_configuration_id"
  end

  create_table "postes", force: :cascade do |t|
    t.bigint "junior_configuration_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_configuration_id"], name: "index_postes_on_junior_configuration_id"
  end

  create_table "prestations", force: :cascade do |t|
    t.bigint "junior_configuration_id", null: false
    t.string "nom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["junior_configuration_id"], name: "index_prestations_on_junior_configuration_id"
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
  add_foreign_key "clients", "juniors"
  add_foreign_key "config_doc_adherents", "junior_configurations"
  add_foreign_key "document_adherents", "adherents"
  add_foreign_key "etapes", "etudes"
  add_foreign_key "etudes", "clients"
  add_foreign_key "etudes", "juniors"
  add_foreign_key "etudes", "prestations"
  add_foreign_key "etudes", "users", column: "charge_etude_id"
  add_foreign_key "etudes", "users", column: "charge_qualite_id"
  add_foreign_key "etudes", "users", column: "charge_rh_id"
  add_foreign_key "junior_configurations", "juniors"
  add_foreign_key "mandat_requests", "membres"
  add_foreign_key "mandat_requests", "poles"
  add_foreign_key "mandat_requests", "postes"
  add_foreign_key "mandats", "mandat_requests"
  add_foreign_key "mandats", "permissions"
  add_foreign_key "membre_requests", "juniors"
  add_foreign_key "membre_requests", "users"
  add_foreign_key "membres", "membre_requests"
  add_foreign_key "permissions", "junior_configurations"
  add_foreign_key "phases", "etapes"
  add_foreign_key "poles", "junior_configurations"
  add_foreign_key "postes", "junior_configurations"
  add_foreign_key "prestations", "junior_configurations"
  add_foreign_key "userparams", "users"
  add_foreign_key "users", "juniors"
end
