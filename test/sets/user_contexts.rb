module Contexts
    module UserContexts
        def create_users
            @hana_user = FactoryBot.create(:user, username: "hana", role: "instructor", phone: "111-111-1111", email: "hana@gmail.com", password: "slowstart")
            @tamate_user = FactoryBot.create(:user, username: "tamate", role: "instructor", phone: "222-222-2222", email: "tamate@gmail.com", password: "eventstill")
            @eiko_user = FactoryBot.create(:user, username: "eiko", role: "instructor", phone: "333-333-3333", email: "eiko@gmail.com", password:"kamukamu")
            
            
        end
        
        def delete_users
            @hana_user.delete
            @tamate_user.delete 
            @eiko_user.delete 
        end 
        
        def create_family_usernames
           @ichinose_user = FactoryBot.create(:user, username: "ichinose", role: "parent", phone: "111-111-1112", email: "ichinose@gmail.com", password: "slowstart1") 
           @momochi_user = FactoryBot.create(:user, username: "momochi", role: "parent", phone: "222-222-2223", email: "momochi@gmail.com", password: "eventstill") 
           @tokura_user = FactoryBot.create(:user, username: "tokura", role: "parent", phone: "333-333-3334", email: "tokura@gmail.com", password:"kamukamu") 
        end
    end
end