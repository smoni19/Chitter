feature "user can post Peep" do
  scenario "users fill out peep form and click Post peep and have peep appear on page" do
    Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
    visit("/login")
    fill_in("email", with: "js2000@test.com")
    fill_in("password", with: "1234")
    click_button("Login")
    fill_in("text", with: "This is a test peep")
    click_button("Post peep")
    expect(page).to have_content("This is a test peep")
  end
end
