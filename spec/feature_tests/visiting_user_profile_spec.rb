require "feature_tests/helper_signup"
require "feature_tests/helper_post_peep"
require 'timecop'

feature "user can view other user's page" do
  before do Timecop.freeze(Time.local(2022, 2, 18, 15, 0, 0)) end
  after do Timecop.return end

  scenario "user clicks a peeper's name and is taken their page" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("Peep 1")
    click_link("js2000", :match => :first)
    expect(page.status_code).to eq 200
    within "//div[@id='peeps']" do
      expect(page.find("li:nth-child(1)")).to have_content "Peep 1"
      expect(page.find("li:nth-child(1)")).to have_content "14:00 - Fri 18th Feb '22"
    end
  end

  scenario "user clicks a peeper's name, is taken to their page and see only their Peeps" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("Peep 1")
    click_link("Logout")
    signup("Jane Smith", "janey12", "jane_smith@example.com", "1234")
    post_peep("Peep 2")
    click_link("js2000")
    expect(page.status_code).to eq 200
    within "//div[@id='peeps']" do
      expect(page.find("li:nth-child(1)")).to have_content "Peep 1"
      expect(page.find("li:nth-child(1)")).to have_content "14:00 - Fri 18th Feb '22"
      expect(page).not_to have_content "Peep 2"
    end
  end

end
