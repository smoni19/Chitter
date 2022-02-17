feature "user can see all Peeps" do
  scenario "users can see all Peeps on homepage in reverse chronological order" do
    Account.create(name: "John Smith", username: "js2000", email: "js2000@test.com", password: "1234")
    visit("/login")
    expect(page.status_code).to eq 200
    fill_in("email", with: "js2000@test.com")
    fill_in("password", with: "1234")
    click_button("Login")
    fill_in("text", with: "Peep 1")
    click_button("Peep!")
    fill_in("text", with: "Peep 2")
    click_button("Peep!")
    expect(page.find('li:nth-child(1)')).to have_content "Peep 2"
    expect(page.find('li:nth-child(2)')).to have_content "Peep 1"
  end
end
