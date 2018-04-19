module Contexts
    module StudentContexts
        def create_students
            
        @ichinoses = FactoryBot.create(:family, user:@hana_user, family_name: "Ichinoses", active: true)
        @momochis = FactoryBot.create(:family, user:@tamate_user, family_name: "Momochis", parent_first_name: "Tama", active: true)
        @tokuras = FactoryBot.create(:family, user:@eiko_user, family_name: "Tokuras", parent_first_name: "Toku", active: false)
            
        @hana = FactoryBot.create(:student, first_name: "Ichinose", last_name: "Hana", family: @ichinoses, date_of_birth: 17.years.ago.to_date, rating: 100, active: true)
        @tamate = FactoryBot.create(:student, first_name: "Momochi", last_name: "Tamate", family: @momochis, date_of_birth: 17.years.ago.to_date, rating: 200, active: true)
        @eiko = FactoryBot.create(:student, first_name: "Tokura", last_name: "Eiko", family: @tokuras, date_of_birth: 17.years.ago.to_date, rating: 102, active: false)
        end
    end
end