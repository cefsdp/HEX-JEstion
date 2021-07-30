# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


junior = Junior.create(nom: "AdminTests", codeje: 'ATJE')
configuration = Configuration.create(junior_id: junior.id)

# User also created on Junior>Create
user = User.create(email: "cefsdp@gmail.com", password: "77262683", junior_id: junior.id, admin: true)