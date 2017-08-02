# frozen_string_literal: true

case Rails.env
when 'development'
  Person.create(name: 'Enot')
  Person.create(name: 'Fenec')
  Person.create(name: 'Tom')
  Person.create(name: 'Simba')
end
