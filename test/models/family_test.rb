require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:user)
  should have_many(:students)
  should have_many(:registrations).through(:students)
  
  
  
  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)
  
  context "Within context" do
    setup do 
      create_family_usernames
      create_families
      create_inactive_families
    end
      
  
    
    should "sort families in ascending order" do
      assert_equal %w[Ichinoses Momochis Tokuras], Family.alphabetical.all.map(&:family_name)  
    end
    
    should "show that family is not destroyable" do 
      deny @momochis.destroy 
    end 
    
    should "show inactive family" do
      delete_families
      assert_equal %w[Tokuras], Family.inactive.all.map(&:family_name).sort
      create_families
    end
    
    should "allow students who havent registered for camps to be destroyed" do 
      assert @tokura_user.destroy
    end
    
    should "remove registraiton when family is inactive" do
      @ichinoses.make_inactive
      assert_equal 0, @ichinoses.registrations.count
    end
    
    should "change nil ratings to 0" do
      @tokuras.rating = nil
      assrt_equal 0, @tokuras.rating
    end

    
  end
end 


