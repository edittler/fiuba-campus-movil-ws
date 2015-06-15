# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: 'admin@fi.uba.ar', password: '12345678')

ariel_alegre_hash = {
  user: {
    email: 'ariel@legre.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Ariel',
    last_name: 'Alegre'
  },
  academic_info: {
    padron: 65834,
    carreer: 'Ingeniería Civil'
  }
}

ariel_alegre = User.create(ariel_alegre_hash[:user])
ariel_alegre.create_wall
ariel_alegre.create_profile(ariel_alegre_hash[:profile])
ariel_alegre.profile.create_city
ariel_alegre.profile.create_nationality
ariel_alegre.profile.create_phone
ariel_alegre.profile.create_location
ariel_alegre.create_academic_info(ariel_alegre_hash[:academic_info])
ariel_alegre.update_attribute(:created_at, 4.months.ago)
ariel_alegre.update_attribute(:approved, true)

juan_dausa_hash = {
  user: {
    email: 'jd@usa.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Juan',
    last_name: 'Dausa'
  },
  academic_info: {
    padron: 92145,
    carreer: 'Ingeniería en Informatica'
  }
}

juan_dausa = User.create(juan_dausa_hash[:user])
juan_dausa.create_wall
juan_dausa.create_profile(juan_dausa_hash[:profile])
juan_dausa.profile.create_city
juan_dausa.profile.create_nationality
juan_dausa.profile.create_phone
juan_dausa.profile.create_location
juan_dausa.create_academic_info(juan_dausa_hash[:academic_info])
juan_dausa.update_attribute(:created_at, 3.months.ago)
juan_dausa.update_attribute(:approved, true)
