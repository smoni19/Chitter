feature "user can sign up" do
  scenario "users fill out sign up form, click Sign Up! button and ther account is created" do
    visit("/signup")
    expect(page.status_code).to eq 200
    fill_in("name", with: "John Smith")
    fill_in("username", with: "js2000")
    fill_in("email", with: "johnsmith@example.com")
    fill_in("password", with: "12345678")
    click_button("Sign up!")
    expect(page).to have_content("John Smith @js2000")
  end
end