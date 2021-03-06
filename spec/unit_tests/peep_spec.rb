require "unit_tests/helper_methods/create_peep"
require "unit_tests/helper_methods/create_user"
require 'timecop'

describe Peep do
  before do Timecop.freeze(Time.local(2022, 2, 18, 15, 0, 0)) end
  after do Timecop.return end

  describe "#create" do
    it "creates a new peep which takes text, post time and id of poster" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      peep = create_peep("Hobnobs are the best biscuit", user)
      expect(peep).to be_a Peep
      expect(peep.text).to eq "Hobnobs are the best biscuit"
      expect(peep.post_time).to eq "2022-02-18 14:00:00+00"
      expect(peep.account_id).to eq user.id
    end
  end

  describe "#edit" do
    it "edits the text of a peep and sets edited to True" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      peep = create_peep("Hobnobs are the best biscuit", user)
      expect(peep.edited).to eq "f"
      edited_peep = Peep.edit(id: peep.id, text: "Hobnobs are the best biscuit, second to Oreos")
      expect(edited_peep.edited).to eq "t"
      expect(edited_peep.text).to eq "Hobnobs are the best biscuit, second to Oreos"
    end
  end

  describe "#delete" do
    it "deletes a peep and removes it from peeps array" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      peep = create_peep("Hobnobs are the best biscuit", user)
      Peep.delete(id: peep.id)
      peeps = Peep.all
      expect(peeps.length).to eq 0
    end
  end

  describe "#all" do
    it "returns all peeps" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      create_peep("Hobnobs are the best biscuit", user)
      create_peep("Fun fact: the can opener was invented over 1000 years before the can", user)
      create_peep("Ignorance, the root and stem of every evil. ― Plato", user)
      peeps = Peep.all
      expect(peeps.length).to eq 3
      expect(peeps[0].text).to eq "Hobnobs are the best biscuit"
      expect(peeps[1].text).to eq "Fun fact: the can opener was invented over 1000 years before the can"
      expect(peeps[2].text).to eq "Ignorance, the root and stem of every evil. ― Plato"
    end
  end

  describe "#convert_time" do
    it "converts the post_time timestamp to a different format" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      peep = create_peep("Hobnobs are the best biscuit", user)
      expect(peep.convert_time(peep.post_time)).to eq "14:00 - Fri 18th Feb '22"
    end
  end

  describe "#check_interacton" do
    it "creates a hashtag by converting a word to a link if it begins with a #" do
      user = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      peep = create_peep("Hobnobs are the best #biscuit", user)
      expect(peep.check_interacton(peep.text, "index")).to eq "Hobnobs are the best <a href=\"hashtag/biscuit\" id=\"interaction\">#biscuit</a>"
    end

    it "creates a mention by converting a word to a link if it begins with an @" do
      user1 = create_user("John Smith", "js2000", "js2000@test.com", "1234")
      user2 = create_user("Jane Smith", "janey12", "jane_smith@example.com", "1234")
      peep = create_peep("Hi @janey12 do you like Hobnobs?", user1)
      expect(peep.check_interacton(peep.text, "index")).to eq "Hi <a href=\"users/janey12\" id=\"interaction\">@janey12</a> do you like Hobnobs?"
    end
  end

end
