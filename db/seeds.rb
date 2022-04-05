# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PASSWORD = '123'

Answer.destroy_all
Question.destroy_all
Application.destroy_all
Property.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('answers')
ActiveRecord::Base.connection.reset_pk_sequence!('questions')
ActiveRecord::Base.connection.reset_pk_sequence!('applications')
ActiveRecord::Base.connection.reset_pk_sequence!('properties')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

# Create administrators
3.times do |n|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "administrator#{n + 1}@user.io",
    administrator: true,
    password: PASSWORD
  )
end

#  Create clients
5.times do |n|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "client#{n + 1}@user.io",
    password: PASSWORD
  )
end

administrators = User.where administrator: true
clients = User.where administrator: false

# Create properties
10.times do
  p_created_at = Faker::Date.between(from: 90.days.ago, to: 16.days.ago)
  p_updated_at = Faker::Date.between(from: p_created_at, to: 11.days.ago)

  p = Property.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    location: Faker::Address.full_address,
    amenities: Faker::Lorem.words.join(','),
    price: Faker::Commerce.price(range: 1700..4700).round,
    user_id: administrators.sample.id,
    created_at: p_created_at,
    updated_at: p_updated_at
  )

  next unless p.persisted?

  # Create only client questions for a property
  rand(1..3).times do
    q_created_at = Faker::Date.between(from: p_created_at, to: 11.days.ago)
    q_updated_at = Faker::Date.between(from: q_created_at, to: 6.days.ago)

    q = Question.create(
      body: Faker::Quotes::Shakespeare.as_you_like_it_quote,
      user_id: clients.sample.id,
      property_id: p.id,
      display: [true, false].sample,
      created_at: q_created_at,
      updated_at: q_updated_at
    )

    next unless q.persisted?

    # Create only client answers for a question
    rand(1..3).times do
      ans_created_at = Faker::Date.between(from: q_created_at, to: 1.days.ago)
      ans_updated_at = Faker::Date.between(from: ans_created_at, to: Date.today)

      Answer.create(
        body: Faker::GreekPhilosophers.quote,
        question_id: q.id,
        user_id: clients.sample.id,
        created_at: ans_created_at,
        updated_at: ans_updated_at
      )
    end
  end

  # Create applications for a property
  rand(1..3).times do
    a_created_at = Faker::Date.between(from: p_created_at, to: 5.days.ago)
    a_updated_at = Faker::Date.between(from: a_created_at, to: Date.today)

    Application.create(
      user_id: clients.sample.id,
      property_id: p.id,
      status: %w[pending rejected approved].sample,
      created_at: a_created_at,
      updated_at: a_updated_at
    )
  end
end

a_users_str = administrators.inject('Administrators') { |memo, user| "#{memo} | #{user.first_name} #{user.last_name}" }
c_users_str = clients.inject('Clients') { |memo, user| "#{memo} | #{user.first_name} #{user.last_name}" }

puts "Generated #{administrators.count} #{a_users_str}"
puts "Generated #{clients.count} #{c_users_str}"
puts "Generated #{Property.count} properties"
puts "Generated #{Question.count} questions"
puts "Generated #{Answer.count} answers"
puts "Generated #{Application.count} applications"
