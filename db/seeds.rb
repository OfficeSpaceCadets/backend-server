
ApiToken.create! token: '24ee441f6823271610ea6c4e57d8541b'

matt = User.create! name: 'Matt', username: 'toddm', email: 'matt.todd@asynchrony.com', external_id: '34_29_88_94_57'
bj = User.create! name: 'BJ', username: 'selfb', email: 'bj.self@asynchrony.com', external_id: '178_130_195_169_90'
lee = User.create! name: 'Lee', username: 'esnerl', email: 'lee.esner@asynchrony.com', external_id: '149_151_178_8_184'
rosemary = User.create! name: 'Rosemary', username: 'kaskowitzr', email: 'rosemary.kaskoitz@asynchrony.com', external_id: '116_209_145_226_214'

PairingSession.create! users: [bj, lee], start_time: 1.hour.ago, end_time: 90.minutes.ago
PairingSession.create! users: [lee, matt], start_time: 20.minutes.ago, end_time: Time.now
PairingSession.create! users: [matt, rosemary], start_time: 5.minutes.ago, end_time: Time.now
PairingSession.create! users: [rosemary, bj], start_time: 1.minute.ago, end_time: Time.now

