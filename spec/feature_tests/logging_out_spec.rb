feature "user can log out" do
  scenario "user clicks Logout link and is logged out" do
    Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
    visit("/login")
    expect(page.status_code).to eq 200
    expect(page).to_not have_content("Logout")
    fill_in("email", with: "js2000@test.com")
    fill_in("password", with: "1234")
    click_button("Login")
    expect(page).to_not have_content("Signup")
    expect(page).to_not have_content("Login")
    expect(page).to have_content("John Smith @js2000")
    click_link("Logout")
    expect(page).to have_content("Welcome to Chitter!")
  end
end
