# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Creator.delete_all
creator1 = Creator.create(username: "Tingeling", email: "ting@ling.com", password: "password")
creator2 = Creator.create(username: "Drottningen", email: "queens@land.com", password: "testtest")
creator3 = Creator.create(username: "Globetrotter", email: "down@under.com", password: "password")
creator4 = Creator.create(username: "Kungen", email: "kings@land.com", password: "testtest")

Tag.delete_all
tag1 = Tag.create(name: "Must-see scrapers!")
tag2 = Tag.create(name: "Best view!")
tag3 = Tag.create(name: "Relaxation!")
tag4 = Tag.create(name: "Amazing island!")
tag5 = Tag.create(name: "Best big city!")

Place.delete_all
Place.create(creator_id: creator1.id, name: "San Fran", text: "The Golden Gate Bridge is amazing!", latitude: 37.774929, longitude: -122.419415, tags: [tag5])
Place.create(creator_id: creator2.id, name: "Empire State Building", text: "Must visit when you are in NYC!", latitude: 40.74844, longitude: -73.985664, tags: [tag1, tag2])
Place.create(creator_id: creator3.id, name: "Gili T", text: "The most beautiful island in Indonesia, must-see place!", latitude: -8.409517, longitude: 115.188916, tags: [tag4])
Place.create(creator_id: creator4.id, name: "Kreta", text: "Such a cosy get away for couples!", latitude: 35.240117, longitude: 24.809269, tags: [tag3])

