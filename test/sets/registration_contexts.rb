module Contexts
    module RegistrationContexts
        def create_registrations
            
            @lovelive = FactoryBot.create(:curriculum, name: "Love Live", min_rating: 300, max_rating: 700, active: true)
            @sunshine = FactoryBot.create(:curriculum, name: "Sunshine", min_rating: 0, max_rating: 1000, active: true)
            
            @numazu = FactoryBot.create(:location, name: "Numazu", street_1: "Nu", max_capacity: 100, zip: 15213, active: true)
            @akiba = FactoryBot.create(:location, name: "Akii", street_1: "Akihabara", max_capacity:150, zip: 12345, active: true)  
            
            @numazucamp = FactoryBot.create(:camp, curriculum: @sunshine, start_date: Date.new(2018,10,9), end_date: Date.new(2018,10,15), time_slot: "pm", location: @numazu, active: true, cost: 150.0)
            @akibacamp = FactoryBot.create(:camp, curriculum: @lovelive, start_date: Date.new(2018,9,10), end_date: Date.new(2018,9,15), time_slot: "pm", location: @akiba, active: true, cost: 120.0)
            
            @hana_1 = FactoryBot.create(:registration, camp: @numazucamp, student: @hana, payment: :"Paid")
            @tamate_2 = FactoryBot.create(:registration, camp: @numazucamp, student: @tamate, payment: "Paid")
            #@eiko_3 = FactoryBot.create(:registration, camp: @akibacamp, student: @eiko)
        end
        
    end
end