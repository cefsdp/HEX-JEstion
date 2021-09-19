# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


junior = Junior.create(nom: "AdminTests", codeje: 'ATJE')
configuration = JuniorConfiguration.create(junior_id: junior.id)

# Default admin user
user = User.create(email: "cefsdp@gmail.com", password: "77262683", junior_id: junior.id, admin: true)
userparam = Userparam.create(user: user)
adherent = Adherent.create(user: user, prenom: 'Charles-Emmanuel', nom: 'Foussé Savoye de Puineuf')

# User also created on Junior>Create
membre_request = MembreRequest.create(junior_id: junior.id, user_id: user.id, status: 'approved')
membre = Membre.create(membre_request_id: membre_request.id, admin:true)
