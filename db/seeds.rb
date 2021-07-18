# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

players = Player.create([{name: 'maja'}, {name: 'sunny'}])

10.times do | index |
  score = Score.create(score: index, player: players.first, created_at: DateTime.now - 1.day)
end

10.times do | index |
  score = Score.create(score: index, player: players.last, created_at: DateTime.now - 1.day)
end

