feature "user can log out" do
  scenario "user clicks Logout link and is logged out" do
    Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
    visit("/login")
    expect(page.status_code).to eq 200
    fill_in("email", with: "js2000@test.com")
    fill_in("password", with: "1234")
    click_button("Login")
    expect(page).to have_content("Hi John Smith, Welcome to Chitter!")
    click_link("Logout")
    expect(page).to have_content("Welcome to Chitter!")
  end
end
