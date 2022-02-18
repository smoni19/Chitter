require "feature_tests/helper_signup"

feature "user can sign up" do
  scenario "users fill out sign up form, click Sign Up! button and ther account is created" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    expect(page).to have_content("John Smith @js2000")
    expect(page.status_code).to eq 200
  end
end
