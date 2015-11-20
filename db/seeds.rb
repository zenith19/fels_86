# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create email: "admin@example.com", password: "12345678", password_confirmation: "12345678", firstname: "Admin", lastname: "Example", admin: true
3.times do |u|
  User.create email: "user#{u+1}@example.com", password: "12345678", password_confirmation: "12345678", firstname: "User #{u+1}", lastname: "Example"
end
2.times do |c|
  category = Category.create! name: "Category #{c+1}"
  20.times do |w|

    word = category.words.create! content: "word_example_#{w+1} C:#{c+1}"
    3.times do |wa|
      word.word_answers.create! content: "word#{w+1}_answer_#{wa+1}"
    end
    word.word_answers.create! content: "word#{w+1}_answer_4", correct: true
  end
end