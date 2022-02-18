require "feature_tests/helper_login"

feature "user can log in" do
  scenario "users fill out log in form, click Login! button and they are logged in" do
    visit("/")
    expect(page).to_not have_content("Logout")
    login("js2000@test.com", "1234")
    expect(page).to have_content("John Smith @js2000")
  end
end
