require "feature_tests/helper_signup"

feature "page title changes" do
  scenario "page title changes when user logs in and navigates to a users page" do
    signup("Jane Smith", "janey12", "jane_smith@example.com", "1234")
    post_peep("Peep 1")
    click_link("Logout")
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("Peep 2")
    expect(title).to eq "Chitter"
    click_link("Jane Smith @janey12")
    expect(title).to eq "Chitter - @janey12"
  end
end
