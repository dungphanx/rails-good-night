# frozen_string_literal: true

# Create users
user1 = User.create(name: 'John')
user2 = User.create(name: 'Jane')
user3 = User.create(name: 'Alice')

# Create sleep records
SleepRecord.create(user: user1, bed_time: Time.new(2023, 7, 1, 22, 0, 0), wake_up_time: Time.new(2023, 7, 2, 6, 30, 0))
SleepRecord.create(user: user2, bed_time: Time.new(2023, 7, 1, 23, 30, 0), wake_up_time: Time.new(2023, 7, 2, 7, 0, 0))
SleepRecord.create(user: user3, bed_time: Time.new(2023, 7, 1, 21, 0, 0), wake_up_time: Time.new(2023, 7, 2, 5, 30, 0))
SleepRecord.create(user: user1, bed_time: Time.new(2023, 7, 2, 22, 30, 0), wake_up_time: Time.new(2023, 7, 3, 7, 30, 0))
SleepRecord.create(user: user2, bed_time: Time.new(2023, 7, 2, 23, 0, 0), wake_up_time: Time.new(2023, 7, 3, 6, 0, 0))
SleepRecord.create(user: user3, bed_time: Time.new(2023, 7, 2, 21, 30, 0), wake_up_time: Time.new(2023, 7, 3, 5, 0, 0))

# Create follows
user1.following_users << user2
user1.following_users << user3
user2.following_users << user3
