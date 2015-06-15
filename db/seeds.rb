# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin.create(email: 'admin@fi.uba.ar', password: '12345678')

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


lionel_messi_hash = {
  user: {
    email: 'lionel@messi.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Lionel',
    last_name: 'Messi'
  },
  academic_info: {
    padron: 90010,
    carreer: 'Ingeniería en Informatica'
  }
}

lionel_messi = User.create(lionel_messi_hash[:user])
lionel_messi.create_wall
lionel_messi.create_profile(lionel_messi_hash[:profile])
lionel_messi.profile.create_city
lionel_messi.profile.create_nationality
lionel_messi.profile.create_phone
lionel_messi.profile.create_location
lionel_messi.create_academic_info(lionel_messi_hash[:academic_info])
lionel_messi.update_attribute(:created_at, 10.months.ago)
lionel_messi.update_attribute(:approved, true)


sergio_aguero_hash = {
  user: {
    email: 'sergio@aguero.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Sergio',
    last_name: 'Aguero'
  },
  academic_info: {
    padron: 90011,
    carreer: 'Ingeniería en Informatica'
  }
}

sergio_aguero = User.create(sergio_aguero_hash[:user])
sergio_aguero.create_wall
sergio_aguero.create_profile(sergio_aguero_hash[:profile])
sergio_aguero.profile.create_city
sergio_aguero.profile.create_nationality
sergio_aguero.profile.create_phone
sergio_aguero.profile.create_location
sergio_aguero.create_academic_info(sergio_aguero_hash[:academic_info])
sergio_aguero.update_attribute(:created_at, 11.months.ago)
sergio_aguero.update_attribute(:approved, true)


pablo_aimar_hash = {
  user: {
    email: 'pablo@aimar.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Pablo',
    last_name: 'Aimar'
  },
  academic_info: {
    padron: 90012,
    carreer: 'Ingeniería en Informatica'
  }
}

pablo_aimar = User.create(pablo_aimar_hash[:user])
pablo_aimar.create_wall
pablo_aimar.create_profile(pablo_aimar_hash[:profile])
pablo_aimar.profile.create_city
pablo_aimar.profile.create_nationality
pablo_aimar.profile.create_phone
pablo_aimar.profile.create_location
pablo_aimar.create_academic_info(pablo_aimar_hash[:academic_info])
pablo_aimar.update_attribute(:created_at, 8.months.ago)
pablo_aimar.update_attribute(:approved, true)


diego_maradona_hash = {
  user: {
    email: 'diego@maradona.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Diego',
    last_name: 'Maradona'
  },
  academic_info: {
    padron: 90013,
    carreer: 'Ingeniería en Informatica'
  }
}

diego_maradona = User.create(diego_maradona_hash[:user])
diego_maradona.create_wall
diego_maradona.create_profile(diego_maradona_hash[:profile])
diego_maradona.profile.create_city
diego_maradona.profile.create_nationality
diego_maradona.profile.create_phone
diego_maradona.profile.create_location
diego_maradona.create_academic_info(diego_maradona_hash[:academic_info])
diego_maradona.update_attribute(:created_at, 5.months.ago)
diego_maradona.update_attribute(:approved, true)


javier_pastore_hash = {
  user: {
    email: 'javier@pastore.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Javier',
    last_name: 'Pastore'
  },
  academic_info: {
    padron: 90014,
    carreer: 'Ingeniería en Informatica'
  }
}

javier_pastore = User.create(javier_pastore_hash[:user])
javier_pastore.create_wall
javier_pastore.create_profile(javier_pastore_hash[:profile])
javier_pastore.profile.create_city
javier_pastore.profile.create_nationality
javier_pastore.profile.create_phone
javier_pastore.profile.create_location
javier_pastore.create_academic_info(javier_pastore_hash[:academic_info])
javier_pastore.update_attribute(:created_at, 1.months.ago)
javier_pastore.update_attribute(:approved, true)


angel_dimaria_hash = {
  user: {
    email: 'angel@dimaria.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Angel',
    last_name: 'Di Maria'
  },
  academic_info: {
    padron: 90015,
    carreer: 'Ingeniería en Informatica'
  }
}

angel_dimaria = User.create(angel_dimaria_hash[:user])
angel_dimaria.create_wall
angel_dimaria.create_profile(angel_dimaria_hash[:profile])
angel_dimaria.profile.create_city
angel_dimaria.profile.create_nationality
angel_dimaria.profile.create_phone
angel_dimaria.profile.create_location
angel_dimaria.create_academic_info(angel_dimaria_hash[:academic_info])
angel_dimaria.update_attribute(:created_at, 6.months.ago)
angel_dimaria.update_attribute(:approved, true)


gonzalo_higuain_hash = {
  user: {
    email: 'gonzalo@higuain.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Gonzalo',
    last_name: 'Higuain'
  },
  academic_info: {
    padron: 90016,
    carreer: 'Ingeniería en Informatica'
  }
}

gonzalo_higuain = User.create(gonzalo_higuain_hash[:user])
gonzalo_higuain.create_wall
gonzalo_higuain.create_profile(gonzalo_higuain_hash[:profile])
gonzalo_higuain.profile.create_city
gonzalo_higuain.profile.create_nationality
gonzalo_higuain.profile.create_phone
gonzalo_higuain.profile.create_location
gonzalo_higuain.create_academic_info(gonzalo_higuain_hash[:academic_info])
gonzalo_higuain.update_attribute(:created_at, 7.months.ago)
gonzalo_higuain.update_attribute(:approved, true)


sergio_romero_hash = {
  user: {
    email: 'sergio@romero.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Sergio',
    last_name: 'Romero'
  },
  academic_info: {
    padron: 90017,
    carreer: 'Ingeniería en Informatica'
  }
}

sergio_romero = User.create(sergio_romero_hash[:user])
sergio_romero.create_wall
sergio_romero.create_profile(sergio_romero_hash[:profile])
sergio_romero.profile.create_city
sergio_romero.profile.create_nationality
sergio_romero.profile.create_phone
sergio_romero.profile.create_location
sergio_romero.create_academic_info(sergio_romero_hash[:academic_info])
sergio_romero.update_attribute(:created_at, 11.months.ago)
sergio_romero.update_attribute(:approved, true)


martin_demichelis_hash = {
  user: {
    email: 'martin@demichelis.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Martin',
    last_name: 'Demichelis'
  },
  academic_info: {
    padron: 90018,
    carreer: 'Ingeniería en Informatica'
  }
}

martin_demichelis = User.create(martin_demichelis_hash[:user])
martin_demichelis.create_wall
martin_demichelis.create_profile(martin_demichelis_hash[:profile])
martin_demichelis.profile.create_city
martin_demichelis.profile.create_nationality
martin_demichelis.profile.create_phone
martin_demichelis.profile.create_location
martin_demichelis.create_academic_info(martin_demichelis_hash[:academic_info])
martin_demichelis.update_attribute(:created_at, 4.months.ago)
martin_demichelis.update_attribute(:approved, true)


marcos_rojo_hash = {
  user: {
    email: 'marcos@rojo.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Marcos',
    last_name: 'Rojo'
  },
  academic_info: {
    padron: 90019,
    carreer: 'Ingeniería en Informatica'
  }
}

marcos_rojo = User.create(marcos_rojo_hash[:user])
marcos_rojo.create_wall
marcos_rojo.create_profile(marcos_rojo_hash[:profile])
marcos_rojo.profile.create_city
marcos_rojo.profile.create_nationality
marcos_rojo.profile.create_phone
marcos_rojo.profile.create_location
marcos_rojo.create_academic_info(marcos_rojo_hash[:academic_info])
marcos_rojo.update_attribute(:created_at, 2.months.ago)
marcos_rojo.update_attribute(:approved, true)


pablo_zabaleta_hash = {
  user: {
    email: 'pablo@zabaleta.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Pablo',
    last_name: 'Zabaleta'
  },
  academic_info: {
    padron: 90020,
    carreer: 'Ingeniería en Informatica'
  }
}

pablo_zabaleta = User.create(pablo_zabaleta_hash[:user])
pablo_zabaleta.create_wall
pablo_zabaleta.create_profile(pablo_zabaleta_hash[:profile])
pablo_zabaleta.profile.create_city
pablo_zabaleta.profile.create_nationality
pablo_zabaleta.profile.create_phone
pablo_zabaleta.profile.create_location
pablo_zabaleta.create_academic_info(pablo_zabaleta_hash[:academic_info])
pablo_zabaleta.update_attribute(:created_at, 1.months.ago)
pablo_zabaleta.update_attribute(:approved, true)


ezequiel_lavezzi_hash = {
  user: {
    email: 'ezequiel@lavezzi.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Ezequiel',
    last_name: 'Lavezzi'
  },
  academic_info: {
    padron: 90021,
    carreer: 'Ingeniería en Informatica'
  }
}

ezequiel_lavezzi = User.create(ezequiel_lavezzi_hash[:user])
ezequiel_lavezzi.create_wall
ezequiel_lavezzi.create_profile(ezequiel_lavezzi_hash[:profile])
ezequiel_lavezzi.profile.create_city
ezequiel_lavezzi.profile.create_nationality
ezequiel_lavezzi.profile.create_phone
ezequiel_lavezzi.profile.create_location
ezequiel_lavezzi.create_academic_info(ezequiel_lavezzi_hash[:academic_info])
ezequiel_lavezzi.update_attribute(:created_at, 5.months.ago)
ezequiel_lavezzi.update_attribute(:approved, true)


neymar_junior_hash = {
  user: {
    email: 'neymar@junior.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Neymar',
    last_name: 'Junior'
  },
  academic_info: {
    padron: 90022,
    carreer: 'Ingeniería en Informatica'
  }
}

neymar_junior = User.create(neymar_junior_hash[:user])
neymar_junior.create_wall
neymar_junior.create_profile(neymar_junior_hash[:profile])
neymar_junior.profile.create_city
neymar_junior.profile.create_nationality
neymar_junior.profile.create_phone
neymar_junior.profile.create_location
neymar_junior.create_academic_info(neymar_junior_hash[:academic_info])
neymar_junior.update_attribute(:created_at, 9.months.ago)
neymar_junior.update_attribute(:approved, true)


cristiano_ronaldo_hash = {
  user: {
    email: 'cristiano@ronaldo.com',
    password: '12345678',
    password_confirmation: '12345678'
  },
  profile: {
    first_name: 'Cristiano',
    last_name: 'Ronaldo'
  },
  academic_info: {
    padron: 90023,
    carreer: 'Ingeniería en Informatica'
  }
}

cristiano_ronaldo = User.create(cristiano_ronaldo_hash[:user])
cristiano_ronaldo.create_wall
cristiano_ronaldo.create_profile(cristiano_ronaldo_hash[:profile])
cristiano_ronaldo.profile.create_city
cristiano_ronaldo.profile.create_nationality
cristiano_ronaldo.profile.create_phone
cristiano_ronaldo.profile.create_location
cristiano_ronaldo.create_academic_info(cristiano_ronaldo_hash[:academic_info])
cristiano_ronaldo.update_attribute(:created_at, 2.months.ago)
cristiano_ronaldo.update_attribute(:approved, true)

