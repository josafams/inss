# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(email: 'admin@example.com', password: '123456')

10.times do |i|
  p = Proponent.create!(
    name: Faker::Name.name,
    document: "000.000.000-0#{i}",
    birthday: Faker::Date.birthday(min_age: 18, max_age: 85),
    salary: rand(1000.0..5000.0)
  )
  p.update(discount_inss: InssCalculatorService.call(p.salary))

  p.addresses.create!(
    public_place: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.city,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code
  )

  p.contacts.create!(contact_type: :celular, value: "9999-999#{i}")
end

proponent = Proponent.last

10.times do |i|
  p = Proponent.create!(
    name: Faker::Name.name,
    document: "000.000.000-0#{i}",
    birthday: Faker::Date.birthday(min_age: 18, max_age: 85),
    salary: rand(1000.0..5000.0)
  )
  p.update(discount_inss: proponent.discount_inss)

  p.addresses.create!(
    public_place: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.city,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code
  )

  p.contacts.create!(contact_type: :celular, value: "9999-999#{i}")
end

User.create email: 'admin@exemplo.com', password: '123456'
