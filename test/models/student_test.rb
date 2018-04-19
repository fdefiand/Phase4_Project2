require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)
  
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  should validate_numericality_of(:family_id)
  
  should allow_value(1000).for(:rating)
  should allow_value(100).for(:rating)
  should allow_value(3000).for(:rating)
  should allow_value(nil).for(:rating)
  should allow_value(0).for(:rating)
  
  should_not allow_value("lol").for(:rating)
  should_not allow_value("3001").for(:rating)
  should_not allow_value("-1").for(:rating)

  
  should allow_value(17.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(Date.today).for(:date_of_birth)
  
  context "Within context" do 
    setup do 
      create_family_usernames
      create_families
      create_students
    end
    
    should "show active students" do 
      assert_equal [], Student.active.all.map(&:first_name).sort
    end 
    
    should "show name method" do 
      assert_equal "Hana, Ichinose", @hana.name
    end
    
    should "allow student with no registered camps to be destroyed" do 
      assert @hana.destroy
    end 
    
    should "allow student to be removed when inactive" do
      @hana.active = false
      assert @hana.destroy
    end
  end
  
end
