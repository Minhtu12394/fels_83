User.create!(name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password

  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|u| user.follow u}
followers.each {|u| u.follow user}

15.times do
  name = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph
  cate = Category.create! name: name, description: description

  40.times do
    word = cate.words.build content: Faker::Lorem.word
    word.answers.build content: Faker::Lorem.word, is_correct: true
    word.answers.build content: Faker::Lorem.word, is_correct: false
    word.answers.build content: Faker::Lorem.word, is_correct: false
    word.answers.build content: Faker::Lorem.word, is_correct: false
    word.save!
  end
end
