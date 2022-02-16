feature "user can post Peep" do
  scenario "users fill out peep form and click Post peep and have peep appear on page" do
    Account.create(name: "Tony Wood", username: "t_w_40", email: "t_w_40@test.com", password: "1234")
    Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
    visit("/login")
    expect(page.status_code).to eq 200
    fill_in("email", with: "js2000@test.com")
    fill_in("password", with: "1234")
    click_button("Login")
    fill_in("text", with: "This is a test peep")
    click_button("Post peep")
    expect(page).to have_content("js2000 peeped: This is a test peep")
  end
end
