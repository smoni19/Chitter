feature "user can log in" do
  scenario "users fill out log in form, click Login! button and they are logged in" do
    Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
    visit("/login")
    expect(page.status_code).to eq 200
    expect(page).to_not have_content("Logout")
    fill_in("email", with: "js2000@test.com")
    fill_in("password", with: "1234")
    click_button("Login")
    expect(page).to have_content("Hi John Smith, Welcome to Chitter!")
  end
end
