# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

matt = User.create name: 'Matt', username: '', email: ''
bj = User.create name: 'BJ', username: '', email: ''
lee = User.create name: 'Lee', username: '', email: ''
rosemary = User.create name: 'Rosemary', username: '', email: ''

PairingSession.create users: [matt, bj], start_time: 1.hour.ago, end_time: 90.minutes.ago
PairingSession.create users: [bj, lee], start_time: 20.minutes.ago, end_time: Time.now
PairingSession.create users: [rosemary, matt], start_time: 5.minutes.ago, end_time: Time.now
