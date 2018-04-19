require 'test_helper'
require 'base64'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)
  
  context "Within context" do 
    setup do 
      create_users
      create_families
      create_family_usernames
      create_students
      create_curriculums
      create_locations
      create_camps
      create_registrations
      create_valid_cards
      create_invalid_card_lengths
    end
    
    should "deny inactive students" do 
      @hana.update(active: false)
      invalid = FactoryBot.build(:registration, student: @hana, camp: @camp1)
      deny invalid.valid?
    end
    
    should "deny inactive camps" do 
      invalid_camp = FactoryBot.build(:registration, student: @hana, camp: @camp3)
      deny invalid_camp.valid?
    end
    
    should "confirm active students" do 
      invalid = FactoryBot.build(:registration, student: @eiko, camp: @camp1)
      deny invalid.valid?
    end
    
    should "confirm ratings" do 
      @hana_endgames = FactoryBot.build(:registration, student: @hana, camp: @numazucamp)
      assert @hana_endgames.valid?
      @tamate_endgames = FactoryBot.build(:registration, student: @tamate, camp: @akibacamp)
      deny @tamate_endgames.valid?
    end
    
    should "detect valid and invalid expiration dates" do 
      @hana_endgames = FactoryBot.build(:registration, student: @hana, camp: @numazucamp)
      @hana_endgames.expiration_year = Date.current.year
      assert @hana_endgames.valid?
      @hana_endgames.credit_card_number = "93134679996183"
      @hana_endgames.expiration_month = Date.current.month
      @hana_endgames.expiration_year = 5.year.ago.year
    end
    
    should "have payment receipt in the proper format" do 
      @hana_endgames = FactoryBot.build(:registration, student: @hana, camp: @numazucamp)
      @hana_endgames.payment = nil
      assert @hana_endgames.save
      @hana_endgames.credit_card_number = "9541456789012"
      @hana_endgames.expiration_month = Date.current.month + 5
      @hana_endgames.expiration_year = Date.current.year
      assert @hana_endgames.valid?
      @hana_endgames.pay
      assert_equal "camp: #{@hana_endgames.camp_id}; student: #{@hana_endgames.student_id}; amount_paid: #{@hana_endgames.camp.cost}****#{@hana_endgames.credit_card_number[-4..-1]}", Base64.decode64(@hana_endgames.payment)
    end
    
  should "confirm new credit card" do
    @hana_endgames1 = FactoryBot.build(:registration, student: @hana, camp: @numazucamp)
    @hana_endgames1.credit_card_number = "9541456789012"
    @hana_endgames1.expiration_month = Date.current.month + 5
    @hana_endgames1.expiration_year = Date.current.year
  end
    
    
    
    
    
  end
end
