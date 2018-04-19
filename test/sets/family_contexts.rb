module Contexts
    module FamilyContexts
        def create_families
            @hana_user = FactoryBot.create(:user, username: "hana", role: "instructor", phone: "111-111-1111", email: "hana1@gmail.com", password: "slowstart")
            @tamate_user = FactoryBot.create(:user, username: "tamate", role: "instructor", phone: "222-222-2222", email: "tamate1@gmail.com", password: "eventstill")
            @eiko_user = FactoryBot.create(:user, username: "eiko", role: "instructor", phone: "333-333-3333", email: "eiko1@gmail.com", password:"kamukamu")
            
            
            @ichinoses = FactoryBot.create(:family, user:@hana_user, family_name: "Ichinoses")
            @momochis = FactoryBot.create(:family, user:@tamate_user, family_name: "Momochis", parent_first_name: "Tama")
           
        end
        
        def delete_families
            @ichinoses.delete
            @momochis.delete
        end
        
        def create_inactive_families
            @tokuras = FactoryBot.create(:family, user:@eiko_user, family_name: "Tokuras", parent_first_name: "Toku", active: false)
        end
    end
end