# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do |i|
  Host.create(name: "khanh#{i}", email: "khanh#{i}@abc.com", password: "12345678",token: "qwertyuiop#{i}", status: "1", delete_flg: "0")
end
