# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#users
User.create(:email => 'a@com', :password => 'shimane')
User.create(:email => 'a@1', :password => '123456', 'authority' => true)
User.create(:email => '1@com', :password => '123456')
User.create(:email => '2@com', :password => '123456')
User.create(:email => '3@com', :password => '123456')
User.create(:email => '4@com', :password => '123456')
User.create(:email => '5@com', :password => '123456')
User.create(:email => '6@com', :password => '123456')
User.create(:email => '7@com', :password => '123456')
User.create(:email => '8@com', :password => '123456')
User.create(:email => '9@com', :password => '123456')
User.create(:email => '10@com', :password => '123456')
User.create(:email => '11@com', :password => '123456')
User.create(:email => '12@com', :password => '123456')
User.create(:email => '13@com', :password => '123456')
User.create(:email => '14@com', :password => '123456')
User.create(:email => '15@com', :password => '123456')
User.create(:email => '16@com', :password => '123456')
User.create(:email => '17@com', :password => '123456')
User.create(:email => '18@com', :password => '123456')
User.create(:email => '19@com', :password => '123456')
User.create(:email => '20@com', :password => '123456')


#categories
Category.create(name: '総合')
Category.create(name: 'ニュース')
Category.create(name: 'カルチャー')
Category.create(name: 'おでかけ')
Category.create(name: 'アイデア')
Category.create(name: '雑学')
Category.create(name: 'アニメ')
Category.create(name: 'おもしろ')
Category.create(name: 'レシピ')
Category.create(name: 'IT')
Category.create(name: '音楽')
Category.create(name: 'エンタメ')
Category.create(name: 'ラジオ')
Category.create(name: '政治')
Category.create(name: 'テレビ')
Category.create(name: '国')
