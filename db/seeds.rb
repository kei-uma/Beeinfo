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
Layout.create(layout: 1)
Layout.create(layout: 2)
Layout.create(layout: 3)
