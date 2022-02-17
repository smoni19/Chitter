require "signup"
require "post_peep"

feature "user can see all Peeps" do
  scenario "users can see all Peeps on homepage in reverse chronological order" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("Peep 1")
    post_peep("Peep 2")
    expect(page.status_code).to eq 200
    expect(page.find("li:nth-child(1)")).to have_content "Peep 2"
    expect(page.find("li:nth-child(2)")).to have_content "Peep 1"
  end
end
