feature "user can sign up" do
  scenario "users fill out sign up form, click Sign Up! button and their account is created" do
    visit("/account/new")
    fill_in("name", with: "John Smith")
    fill_in("username", with: "js2000")
    fill_in("email", with: "johnsmith@example.com")
    fill_in("password", with: "12345678")
    click_button("Sign up!")
    expect(page).to have_content("Welcome to Chitter!")
  end
end
