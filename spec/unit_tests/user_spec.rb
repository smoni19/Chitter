require "account"
require "unit_tests/helper_methods/create_user"

describe Account do
  describe "#create" do
    it "creates a new user" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      expect(user).to be_a Account
      expect(user.name).to eq "John Smith"
      expect(user.username).to eq "js2000"
      expect(user.email).to eq "js2000@test.com"
    end
  end

  describe "#login" do
    it "logs in a user if they have signed up" do
      user1 = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      user2 = create_user("Jane Smith", "janey12", "jane_smith@example.com", "1234")
      user1 = Account.login(email: "js2000@test.com", password: "1234")
      expect(user1.name).to eq "John Smith"
    end
  end

end
