require "account"

describe Account do
  describe "#create" do
    it "creates a new user" do
      user = Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
      expect(user).to be_a Account
      expect(user.name).to eq "John Smith"
      expect(user.username).to eq "js2000"
      expect(user.email).to eq "js2000@test.com"
    end
  end

  describe '#login' do
    it "logs in a user if they have signed up" do
      Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
      Account.create(name: "Jane Smith", username: "janey12", email: "jane_smith@example.com", password: "1234")
      user = Account.login(email: "js2000@test.com", password: "1234")
      expect(user.name).to eq "John Smith"
    end
  end

end
