require 'open-uri'
require 'json'
# il faut créer un user et associer le chien au user
User.destroy_all
Walk.destroy_all

p "Création d'un user "
user1 = User.new(username: "Chonchax", email: "test@gmail.com", password: "azerty", address: "20 Rue des Capucins, Lyon")
if user1.save
  p "user créé"
else
  p "Soucis avec la création du user"
end

dog1 = Dog.new(name: "Rex", breed: "Berger Australien", age: 4,
              energy: 3, playfulness: 5, good_with_strangers: 5,
              good_with_others_dogs: 5, good_with_chidren: 4,
              size: "Grand", neutered: true, good_with_water: 3,
              shadow_level: 3, sexe: "Male", user_id: user1.id)
if dog1.save
  p "Chien créé"
else
  p "Soucis avec la création du chien"
end

p "Création d'un user "
user2 = User.new(username: "AnneFlorette", email: "toto@gmail.com", password: "azerty", address: "20 Rue des Capucins, Lyon")
if user2.save
  p "user créé"
else
  p "Soucis avec la création du user"
end

dog2 = Dog.new(name: "Ostia", breed: "Golden Retriver", age: 7,
              energy: 2, playfulness: 4, good_with_strangers: 4,
              good_with_others_dogs: 3, good_with_chidren: 1,
              size: "Grand", neutered: true, good_with_water: 5,
              shadow_level: 5, sexe: "Female", user_id: user2.id)
if dog2.save
  p "Chien 2 créé"
else
  p "Soucis avec la création du chien"
end


p "Création d'un user "
user3 = User.new(username: "Camelito", email: "caca@gmail.com", password: "azerty", address: "20 Rue des Capucins, Lyon")
if user3.save
  p "user créé"
else
  p "Soucis avec la création du user"
end

dog3 = Dog.new(name: "Buddy", breed: "Teckel", age: 2,
              energy: 5, playfulness: 5, good_with_strangers: 5,
              good_with_others_dogs: 5, good_with_chidren: 5,
              size: "Petit", neutered: true, good_with_water: 5,
              shadow_level: 3, sexe: "Female", user_id: user3.id)
if dog3.save
  p "Chien 3 créé"
else
  p "Soucis avec la création du chien"
end

# walk = Walk.new(start_address_longitude: 4.832184, start_address_latitude: 45.75783,
#                 city: "Lyon", distance: 3.5, title: "Test balade",
#                 difficulty: 2, leash: true, water_presence: 3,
#                 shadow_presence: 3)

# if walk.save
#   p "balade créé"
# else
#   p "Soucis avec la création de la balade"
# end

url = "https://data.grandlyon.com/geoserver/metropole-de-lyon/ows?SERVICE=WFS&VERSION=2.0.0&request=GetFeature&typename=metropole-de-lyon:evg_esp_veg.envpdiprboucle&outputFormat=application/json&SRSNAME=EPSG:4171&startIndex=0&sortBy=gid&count=100"

puts "Je choppe la balade"
file = URI.open(url)
walks = JSON.parse(file.read)
walks['features'].each do |walk|
  Walk.create(
    city: walk['properties']['commune_depart'],
    title: walk['properties']['nom'],
    distance: walk['properties']['longueur'],
    difficulty: walk['properties']['difficulte'],
    start_address_longitude: walk['properties']['xdepart'],
    start_address_latitude: walk['properties']['ydepart'],
    geometry: walk['geometry']
  )
end
puts "jai fini de chopper"
bug = Walk.where(title: "Jeu de Regards sur Méginand")
bug.destroy(bug.ids)

puts "bug destroy"



