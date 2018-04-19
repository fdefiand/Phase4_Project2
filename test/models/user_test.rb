require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should validate_presence_of(:username)
  should have_secure_password
  
  should allow_value("admin").for(:role)
  should allow_value("parent").for(:role)
  should allow_value("instructor").for(:role)
  should_not allow_value("lol").for(:role)
  should_not allow_value(1).for(:role)
  should_not allow_value(nil).for(:role)
  
  should allow_value("fdefiand@gmail.com").for(:email)
  should allow_value("fdefiand@qatar.cmu.edu").for(:email)
  should allow_value("f_defiand@fdefiand.org").for(:email)
  should allow_value("fdefiand@gmail.gov").for(:email)
  should allow_value("fdefiand@gmail.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  
  context "Within context" do
    setup do
      create_users
    end
    
    should "require users to have unique usernames" do
      assert_equal "hana", @hana.username
    end
    
    should "allow user to enter with password" do
      assert @hana_user.authenticate("slowstart")
      deny @hana_user.authenticate("faststart")
    end
    
    should "require password" do
      invalid = FactoryBot.build(:user, username:"kamuri", password: nil, email: "kamuri@gmail.com", phone: "111-111-1111")
      deny @invalid.valid?
    end
    
     should "shows that Eiko's phone is stripped of non-digits" do
      assert_equal "3333333333", @eiko_user.phone
    end
    
  end
end
