
ApiToken.create! token: '24ee441f6823271610ea6c4e57d8541b'

matt = User.create! name: 'Matt', username: '', email: ''
bj = User.create! name: 'BJ', username: '', email: ''
lee = User.create! name: 'Lee', username: '', email: ''
rosemary = User.create! name: 'Rosemary', username: '', email: ''

PairingSession.create! users: [bj, lee], start_time: 1.hour.ago, end_time: 90.minutes.ago
PairingSession.create! users: [lee, matt], start_time: 20.minutes.ago, end_time: Time.now
PairingSession.create! users: [matt, rosemary], start_time: 5.minutes.ago, end_time: Time.now
PairingSession.create! users: [rosemary, bj], start_time: 1.minute.ago, end_time: Time.now

