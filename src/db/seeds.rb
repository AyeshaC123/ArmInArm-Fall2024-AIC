# frozen_string_literal: true

require 'csv'
require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create the global configuration
# create! makes the object and automatically saves it to the database
# the ! means that if something goes wrong and cannot save, throw an exception
AppConfig.create!(name: 'Client Portal', logo_url: 'hhhhhhh')

if Rails.env.development?

  # We're in a development mode, so making fake, insecure data is fine
  # Create two user profiles, admin and unprivledged user
  # Right now, there is no difference between the accounts
  # If your project needs it, add a boolean field to user for administrator


  #admin = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, role: :admin, registered: false)
  #user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password', admin: false, registered: false)

   # admin = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, role: :admin, registered: false)
  # user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password', admin: false, registered: false)

  # 20.times do
  #   adob = Faker::Date.birthday(min_age: 18, max_age: 65)
  #   anAddress = Faker::Address.full_address
  #   fname = Faker::Name.first_name
  #   lname = Faker::Name.last_name

  #   client = Client.create(
  #     first_name: fname,
  #     last_name: lname,
  #     dob: adob,
  #     address: anAddress,
  #   )
  #   user = User.create(
  #     email: Faker::Internet.unique.email,
  #     password: 'password',
  #     password_confirmation: 'password',
  #     reset_password_sent_at: nil,
  #     remember_created_at: nil,
  #     role: 0,
  #     registered: [true, false].sample,
  #     client: client
  #   )

  #   household = Household.create(
  #     headname: "#{fname} #{lname}",
  #     headdob: adob,
  #     numadults: [1, 1, 2, 2, 2, 3].sample,
  #     numchild: [0, 1, 1, 2, 3].sample,
  #     streetaddr: anAddress,
  #     city: 'Trenton',
  #     state: 'NJ',
  #     county: 'A County',
  #     zipcode: '08080',
  #     phonenum: 'x',
  #     householdtype: 'x',
  #     headgender: 'x',
  #     headethnicity: 'x',
  #     foodstamps: 'x',
  #     incomesource: 'x',
  #     qualifiercode: 'x',
  #     netincome: 1,
  #     user: user
  #   )

  # end


  def getRandomTime(dateObj)
    hour = rand(0..23)
    minute = rand(0..59)

    # Create a DateTime object with the random time components
    random_datetime = DateTime.new(
      dateObj.year,
      dateObj.month,
      dateObj.day,
      hour,
      minute,
      0
    )
  end

  allClients = Client.all

  start_date = Date.today
  dob = Date.parse("01/01/2000")
  start_time = Time.now.strftime("%I:%M %p")

  curr_date = start_date
  meanAppointments = 60
  appointmentStdDev = 15
  distribution = Distribution::Normal.rng(meanAppointments, appointmentStdDev)
  # for i in 1..365 do # past appointments users attended
  #   numAppointments = distribution.call.to_i
  #   for j in 1..numAppointments
  #     aClient = allClients.sample
  #     aClientID = aClient.id
  #     new_appointment = Appointment.create(
  #       date_of_appt: (curr_date - i.days),
  #       time_of_appt: getRandomTime(curr_date - i.days),
  #       location: ["Trenton", "Princeton", "Mobile Pantry"].sample,
  #       last_name: Faker::Name.last_name,
  #       dob: dob,
  #       date_of_appts: (curr_date - i.days),
  #       time_of_appts: start_time,
  #       client_id: aClientID,
  #       check_in_user: true,
  #       client: aClient
  #     )
  #   end
  # end

  for i in 0..30 do # future appointments next month
    numAppointments = distribution.call.to_i
    for j in 1..numAppointments
      aClient = allClients.sample
      aClientID = allClients.ids
      new_appointment = Appointment.create(
        date_of_appt: (curr_date + i.days),
        time_of_appt: getRandomTime(curr_date),
        # time_of_appt: getRandomTime(curr_date + i.days),
        location: ["Trenton", "Princeton", "Mobile Pantry"].sample,
        last_name: Faker::Name.last_name,
        dob: dob,
        date_of_appts: (curr_date - i.days),
        time_of_appts: start_time,
        client_id: aClientID,
        client_self_check_in: [true, false].sample,
        check_in_user: false,
        client: aClient
      )
    end
   end

  admin = User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, role: :admin, registered: false)
   user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password', admin: false, registered: false)

elsif Rails.env.production?

  # We're in a production application! Stay secure! No accounts with password!

end


# SP24 Team 14: Added translations here

# Google translated:
Translation.create!(key: "nav_home", en: "Home", es: "Hogar", ht: "Lakay")
Translation.create!(key: "nav_prereg", en: "Pre-Register", es: "Pre-Registrarse", ht: "Pre-Enskri")
Translation.create!(key: "nav_appointments", en: "Appointments", es: "Citas", ht: "Randevou")
Translation.create!(key: "nav_volunteer", en: "Volunteer", es: "Ofrecerse", ht: "Volontè")
Translation.create!(key: "nav_volunteer_hours", en: "View Upcoming Volunteer Hours", es: "Ver las próximas horas de voluntariado", ht: "Gade Orè volontè k ap vini yo")
Translation.create!(key: "nav_volunteer_form", en: "Fill out Volunteer Form", es: "Complete el formulario de voluntariado", ht: "Ranpli Fòm Volontè")
Translation.create!(key: "nav_accessibility", en: "Accessibility", es: "Accesibilidad", ht: "Aksesiblite")
Translation.create!(key: "nav_accessibility_colorblind", en: "Toggle Colorblind Mode", es: "Alternar modo daltónico", ht: "Aktive mòd daltonòm")
Translation.create!(key: "nav_accessibility_dyslexic", en: "Toggle Dyslexic Font", es: "Alternar fuente disléxica", ht: "Deklanche font dizleksik")
#

Translation.create!(key: "client_profile_title", en: "Client Profile Registration and Search Portal", es: "Registro de Perfil de Cliente y Portal de Búsqueda", ht: "Enskripsyon Pwofil Kliyan ak Portal Rechèch")
Translation.create!(key: "client_profile_create", en: "Create Client Profile", es: "Crear Perfil de Cliente", ht: "Kreye Pwofil Kliyan")
Translation.create!(key: "client_profile_modify", en: "View or Modify Client Profile", es: "Ver o Modificar el Perfil de Cliente", ht: "Wè Oswa Modifye Pwofil Kliyan An")
Translation.create!(key: "client_profile_search", en: "Search", es: "Buscar", ht: "Rechèch")

Translation.create!(key: "new_client_first_name", en: "Please enter first name:", es: "Por favor ingrese el nombre:", ht: "Tanpri antre premye non:")
Translation.create!(key: "new_client_last_name", en: "Please enter last name:", es: "Por favor ingrese el apellido:", ht: "Tanpri antre siyati non ou:")
Translation.create!(key: "new_client_birthdate", en: "Please enter date of birth:", es: "Por favor ingrese la fecha de nacimiento:", ht: "Tanpri antre dat desans ou:")
Translation.create!(key: "new_client_next", en: "Next", es: "Próxima", ht: "Pwochen")
Translation.create!(key: "new_client_address", en: "Please enter home address (optional):", es: "Por favor, ingrese la dirección (opcional):", ht: "Tanpri antre adrès lakay ou (opsyonèl):")
Translation.create!(key: "new_client_religion", en: "Please enter religion (optional):", es: "Por favor, ingrese su religión (opcional):", ht: "Tanpri antre relijyon ou (opsyonèl):")
Translation.create!(key: "new_client_allergies_label", en: "Allergies", es: "Alergias", ht: "Alèji")
Translation.create!(key: "new_client_allergy_peanuts", en: "Peanuts", es: "Cacahuetes", ht: "Pistach")
Translation.create!(key: "new_client_allergy_treenuts", en: "Tree nuts", es: "Frutos secos de árbol", ht: "Fwi Pye Bwa")
Translation.create!(key: "new_client_allergy_eggs", en: "Eggs", es: "Huevos", ht: "Ze")
Translation.create!(key: "new_client_allergy_milk", en: "Milk", es: "Leche", ht: "Lèt")
Translation.create!(key: "new_client_allergy_shellfish", en: "Shellfish", es: "Mariscos", ht: "Alèji Kribich")
Translation.create!(key: "new_client_allergy_fish", en: "Fish", es: "Pez", ht: "Pwason")
Translation.create!(key: "new_client_allergy_wheat", en: "Wheat", es: "Trigo", ht: "Blé")
Translation.create!(key: "new_client_allergy_soy", en: "Soy", es: "Soja", ht: "Soya")
Translation.create!(key: "new_client_restrictions_label", en: "Dietary Restrictions", es: "Restricciones de la Dieta", ht: "Restriksiyon de Manje")
Translation.create!(key: "new_client_gluten_free", en: "Gluten-free", es: "Comida Sin Gluten", ht: "Manje San Gluten")
Translation.create!(key: "new_client_vegan", en: "Vegan", es: "Vegano", ht: "Vejetaryen")
Translation.create!(key: "new_client_anything_else", en: "Any other allergens or dietary restrictions? Leave blank if not applicable.", es: "¿Tiene otros alérgenos o restricciones dietéticas? Dejar en blanco si no es aplicable.", ht: "Ou genyen nenpòt lot alèji oswa restriksyon? Pa ekri anyen si repons ou se non.")

# Google translated:
Translation.create!(key: "prereg_header", en: "Pre-Registration Form", es: "Formulario de Preinscripción", ht: "Fòm Pre-Enskripsyon")
Translation.create!(key: "prereg_pantry", en: "Preferred Pantry Location", es: "Ubicación preferida de la despensa", ht: "Kote gadmanje pi pito")
#

Translation.create!(key: "prereg_header_gen_info", en: "General Information", es: "Información General", ht: "Enfòmasyon Jeneral")
Translation.create!(key: "prereg_header_house_adr", en: "Household Address", es: "Direccion de Casa", ht: "Adrès Kay La")
Translation.create!(key: "prereg_header_house_demo", en: "Household Demographics", es: "Demografía del Hogar", ht: "Demografik Nan Kay La")
Translation.create!(key: "prereg_header_house_inc", en: "Household Income & Benefits", es: "Ingresos y Beneficios del Hogar", ht: "Revni ak Benefis nan kay la")
Translation.create!(key: "prereg_submit_form", en: "Submit Form", es: "Enviar el Formulario", ht: "Soumèt Fòm")
Translation.create!(key: "prereg_name", en: "Please enter your name:", es: "Por favor, escriba su nombre:", ht: "Tanpri antre non:")
Translation.create!(key: "prereg_phone_number", en: "Mobile Phone:", es: "Teléfono Móvil:", ht: "Telefòn Mobil:")
Translation.create!(key: "prereg_street", en: "Street:", es: "Calle:", ht: "Lari:")
Translation.create!(key: "prereg_city", en: "City:", es: "Ciudad:", ht: "Vil la:")
Translation.create!(key: "prereg_state", en: "State:", es: "Estado:", ht: "Eta:")
Translation.create!(key: "prereg_county", en: "County:", es: "Condado:", ht: "Konte:")
Translation.create!(key: "prereg_country", en: "Country:", es: "País:", ht: "Peyi:")
Translation.create!(key: "prereg_zip_code", en: "Zip Code:", es: "Código Postal:", ht: "Kòd postal:")
Translation.create!(key: "prereg_household_type", en: "Household type:", es: "Tipo de Hogar:", ht: "Kalite kay:")
Translation.create!(key: "prereg_single_individual", en: "Single Individual", es: "Individuo Soltero", ht: "Endividi selibatè")
Translation.create!(key: "prereg_adults_only", en: "Adults Only", es: "Sólo Adultos", ht: "Granmoun sèlman")
Translation.create!(key: "prereg_fam_with_children_under18", en: "Family with Children Under 18", es: "Familia con niños menores de 18 años", ht: "Fanmi ki gen timoun anba 18 an")
Translation.create!(key: "prereg_hoh_dob", en: "Date of Birth:", es: "Fecha de Nacimiento:", ht: "Dat Nesans:")
Translation.create!(key: "prereg_hoh_gender", en: "Head of Household Gender:", es: "Sexo del Jefe de Hogar:", ht: "Sèks chèf nan kay la:")
Translation.create!(key: "prereg_female", en: "Female", es: "Femenina", ht: "Fi")
Translation.create!(key: "prereg_male", en: "Male", es: "Masculino", ht: "Gason")
Translation.create!(key: "prereg_other", en: "Other", es: "Otro", ht: "Lòt")
Translation.create!(key: "prereg_hoh_race_ethnicity", en: "Head of Household Race/Ethnicity:", es: "Jefe de Hogar Raza/Etnicidad:", ht: "Ras / Etnisite chèf nan kay la:")
Translation.create!(key: "prereg_hoh_black", en: "African American / Black", es: "Afroamericano", ht: "Afriken Ameriken / Nwa")
Translation.create!(key: "prereg_hoh_white", en: "White", es: "Blanco", ht: "Blan")
Translation.create!(key: "prereg_hoh_latino", en: "Latino", es: "Latino", ht: "Panyòl")
Translation.create!(key: "prereg_hoh_asian", en: "Asian", es: "Asiático", ht: "Azyatik")
Translation.create!(key: "prereg_hoh_multiracial", en: "Multiracial", es: "Multiracial", ht: "Multirasyal")
Translation.create!(key: "prereg_num_adults", en: "Number of adults in the household:", es: "Numero de Adultos en el Hogar:", ht: "Kantite granmoun nan kay la:")
Translation.create!(key: "prereg_num_children", en: "Number of children in the household:", es: "Numero de Niños en el Hogar:", ht: "Kantite timoun nan kay la:")
Translation.create!(key: "prereg_receive_snaps", en: "Does the client receive SNAP (Food Stamps)?", es: "¿El cliente recibe SNAP (Cupones para Alimentos)?", ht: "Eske ou te resevwa SNAP (Food Stamp)?")
Translation.create!(key: "prereg_snaps_yes", en: "Yes", es: "Sí", ht: "Wi")
Translation.create!(key: "prereg_snaps_no", en: "No", es: "No", ht: "Non")
Translation.create!(key: "prereg_income_source", en: "Primary Source of Income:", es: "Fuente Primaria de Ingresos:", ht: "Prensipal sous lajan ou:")
Translation.create!(key: "prereg_child_support", en: "Child Support", es: "Manutención de los hijos", ht: "Sipò pou timoun")
Translation.create!(key: "prereg_employment", en: "Employment", es: "Empleo", ht: "Travay")
Translation.create!(key: "prereg_gen_assistance", en: "General Assistance", es: "Asistencia General", ht: "Asistans Jeneral")
Translation.create!(key: "prereg_soc_security", en: "Social Security (SSI)", es: "Seguridad Social (SSI)", ht: "Revni Sekirite Sosyal")
Translation.create!(key: "prereg_soc_sec_disability", en: "Social Security Disability (SSD)", es: "Incapacidad del Seguro Social", ht: "Andikap Sekirite Sosyal")
Translation.create!(key: "prereg_retirement", en: "Retirement", es: "Jubilación", ht: "Retrèt")
Translation.create!(key: "prereg_tanf", en: "TANF", es: "TANF", ht: "TANF")
Translation.create!(key: "prereg_unemployment", en: "Unemployment Benefits", es: "Beneficios de Desempleado", ht: "Benefis chomaj")
Translation.create!(key: "prereg_none", en: "None", es: "Nada", ht: "Anyen")
Translation.create!(key: "prereg_qualifier_code", en: "Qualifier Code:", es: "Código Calificador:", ht: "Kòd kalifikasyon:")
Translation.create!(key: "prereg_code_tanf", en: "1 - TANF", es: "1 - TANF", ht: "1 - TANF")
Translation.create!(key: "prereg_code_snap", en: "2 - SNAP", es: "2 - SNAP", ht: "2 - SNAP")
Translation.create!(key: "prereg_code_ssi", en: "3 - SSI", es: "3 - SSI", ht: "3 - SSI")
Translation.create!(key: "prereg_code_wic", en: "4 - WIC", es: "4 - WIC", ht: "4 - WIC")
Translation.create!(key: "prereg_code_medicaid", en: "5 - Medicaid", es: "5 - Medicaid", ht: "5 - Medicaid")
Translation.create!(key: "prereg_code_inc_eligible", en: "6 - Income Eligible", es: "6 - Ingresos Elegibles", ht: "6 - Revni Elijib")
Translation.create!(key: "prereg_code_disaster", en: "7 - Disaster", es: "7 - Desastre", ht: "7 - Dezas")
Translation.create!(key: "prereg_net_income", en: "Net Income: $", es: "Ingresos Netos: $", ht: "Revni nèt: $")

Translation.create!(key: "prereg_show_name", en: "Head of Household Name:", es: "Nombre del jefe de familia:", ht: "Non chèf fanmi:")

Translation.create!(key: "months_jan", en: "January", es: "Enero", ht: "Janvye")
Translation.create!(key: "months_feb", en: "February", es: "Febrero", ht: "Fevriye")
Translation.create!(key: "months_mar", en: "March", es: "Marzo", ht: "Mas")
Translation.create!(key: "months_apr", en: "April", es: "Abril", ht: "Avril")
Translation.create!(key: "months_may", en: "May", es: "Mayo", ht: "Me")
Translation.create!(key: "months_jun", en: "June", es: "Junio", ht: "Jen")
Translation.create!(key: "months_jul", en: "July", es: "Julio", ht: "Jiyè")
Translation.create!(key: "months_aug", en: "August", es: "Agosto", ht: "Out")
Translation.create!(key: "months_sep", en: "September", es: "Septiembre", ht: "Septanm")
Translation.create!(key: "months_oct", en: "October", es: "Octubre", ht: "Oktòb")
Translation.create!(key: "months_nov", en: "November", es: "Noviembre", ht: "Novanm")
Translation.create!(key: "months_dec", en: "December", es: "Diciembre", ht: "Desanm")

Translation.create!(key: "non_hoh_add", en: "Add Household Member", es: "Agregar Miembro del Hogar", ht: "Ajoute Manm Kay la")
Translation.create!(key: "non_hoh_member", en: "Member", es: "Miembro", ht: "Manm")
Translation.create!(key: "non_hoh_first_name", en: "First name: ", es: "Nombre de pila: ", ht: "Premye Non: ")
Translation.create!(key: "non_hoh_last_name", en: "Last name: ", es: "Apellido: ", ht: "Non Dènye: ")
Translation.create!(key: "non_hoh_relationship", en: "Relationship to the Head of Household:", es: "Relación con la Jefe/a de Hogar:", ht: "Relasyon ak chèf kay la:")
Translation.create!(key: "non_hoh_desc_spouse", en: "Spouse", es: "Esposo/a", ht: "Konjwen")
Translation.create!(key: "non_hoh_desc_child", en: "Child", es: "Niño/a", ht: "Timoun")
Translation.create!(key: "non_hoh_desc_mother", en: "Mother", es: "Madre", ht: "Madre")
Translation.create!(key: "non_hoh_desc_father", en: "Father", es: "Padre", ht: "Padre")
Translation.create!(key: "non_hoh_desc_sibling", en: "Sibling", es: "Hermano/a", ht: "Frè/Sè")
Translation.create!(key: "non_hoh_desc_grandchild", en: "Grandchild", es: "Nieto/a", ht: "Pitit pitit")
Translation.create!(key: "non_hoh_desc_grandparent", en: "Grandparent", es: "Abuelo/a", ht: "Granparan")
Translation.create!(key: "non_hoh_desc_niece", en: "Niece", es: "Sobrina", ht: "Nyès")
Translation.create!(key: "non_hoh_desc_nephew", en: "Nephew", es: "Sobrino", ht: "Neveu")
Translation.create!(key: "non_hoh_desc_aunt", en: "Aunt", es: "Tía", ht: "Matant")
Translation.create!(key: "non_hoh_desc_uncle", en: "Uncle", es: "Tío", ht: "Tonton")
Translation.create!(key: "non_hoh_desc_cousin", en: "Cousin", es: "Primo/a", ht: "Kouzen")
Translation.create!(key: "non_hoh_desc_son_in_law", en: "Son-in-Law", es: "Yerno", ht: "Bofis")
Translation.create!(key: "non_hoh_desc_daughter_in_law", en: "Daughter-in-Law", es: "Nuera", ht: "Bèlfi")
Translation.create!(key: "non_hoh_desc_parent_in_law", en: "Mother/Father-in-Law", es: "Consuegro/a", ht: "Bopè/Bèl mè")
Translation.create!(key: "non_hoh_desc_friend", en: "Friend", es: "Amigo/a", ht: "Zanmi")
Translation.create!(key: "household_created", en: "Household was successfully added. Add additional members through the edit button on My Account page.", es: "El hogar fue añadido con éxito. Añadir miembros adicionales por el botón de editar en mi página de Mi Cuenta.", ht: "El hogar se agregó correctamente. Agregue miembros adicionales a través del botón editar en la página Mi Cuenta.")

# Seed States
state_names = [
  { name: "Alabama", abbreviation: "AL" },
  { name: "Alaska", abbreviation: "AK" },
  { name: "Arizona", abbreviation: "AZ" },
  { name: "Arkansas", abbreviation: "AR" },
  { name: "California", abbreviation: "CA" },
  { name: "Colorado", abbreviation: "CO" },
  { name: "Connecticut", abbreviation: "CT" },
  { name: "Delaware", abbreviation: "DE" },
  { name: "Florida", abbreviation: "FL" },
  { name: "Georgia", abbreviation: "GA" },
  { name: "Hawaii", abbreviation: "HI" },
  { name: "Idaho", abbreviation: "ID" },
  { name: "Illinois", abbreviation: "IL" },
  { name: "Indiana", abbreviation: "IN" },
  { name: "Iowa", abbreviation: "IA" },
  { name: "Kansas", abbreviation: "KS" },
  { name: "Kentucky", abbreviation: "KY" },
  { name: "Louisiana", abbreviation: "LA" },
  { name: "Maine", abbreviation: "ME" },
  { name: "Maryland", abbreviation: "MD" },
  { name: "Massachusetts", abbreviation: "MA" },
  { name: "Michigan", abbreviation: "MI" },
  { name: "Minnesota", abbreviation: "MN" },
  { name: "Mississippi", abbreviation: "MS" },
  { name: "Missouri", abbreviation: "MO" },
  { name: "Montana", abbreviation: "MT" },
  { name: "Nebraska", abbreviation: "NE" },
  { name: "Nevada", abbreviation: "NV" },
  { name: "New Hampshire", abbreviation: "NH" },
  { name: "New Jersey", abbreviation: "NJ" },
  { name: "New Mexico", abbreviation: "NM" },
  { name: "New York", abbreviation: "NY" },
  { name: "North Carolina", abbreviation: "NC" },
  { name: "North Dakota", abbreviation: "ND" },
  { name: "Ohio", abbreviation: "OH" },
  { name: "Oklahoma", abbreviation: "OK" },
  { name: "Oregon", abbreviation: "OR" },
  { name: "Pennsylvania", abbreviation: "PA" },
  { name: "Rhode Island", abbreviation: "RI" },
  { name: "South Carolina", abbreviation: "SC" },
  { name: "South Dakota", abbreviation: "SD" },
  { name: "Tennessee", abbreviation: "TN" },
  { name: "Texas", abbreviation: "TX" },
  { name: "Utah", abbreviation: "UT" },
  { name: "Vermont", abbreviation: "VT" },
  { name: "Virginia", abbreviation: "VA" },
  { name: "Washington", abbreviation: "WA" },
  { name: "West Virginia", abbreviation: "WV" },
  { name: "Wisconsin", abbreviation: "WI" },
  { name: "Wyoming", abbreviation: "WY" }
]

# Seed the database of all US states to use dropdowns
state_names.each do |state|
  State.find_or_create_by!(name: state[:name], abbreviation: state[:abbreviation])
end

# Seed the database of all US counties to use dropdowns
county_names = File.read(Rails.root.join('lib', 'seeds', 'county_list.csv'))
csv = CSV.parse(county_names, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  County.find_or_create_by!(county_name: row['county_name'], state_name: row['state_name'])
end

