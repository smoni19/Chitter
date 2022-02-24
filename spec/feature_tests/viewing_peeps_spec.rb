require "feature_tests/helper_methods/signup"
require "feature_tests/helper_methods/post_peep"
require 'timecop'

feature "user can see all Peeps" do
  before do Timecop.freeze(Time.local(2022, 2, 18, 15, 0, 0)) end
  after do Timecop.return end

  scenario "users can see all Peeps on homepage in reverse chronological order" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("Peep 1")
    post_peep("Peep 2")
    expect(page.status_code).to eq 200
    within "//div[@id='peeps']" do
      expect(page.find("li:nth-child(1)")).to have_content "Peep 2"
      expect(page.find("li:nth-child(2)")).to have_content "Peep 1"
      expect(page.find("li:nth-child(2)")).to have_content "14:00 - Fri 18th Feb '22"
    end
  end
end
