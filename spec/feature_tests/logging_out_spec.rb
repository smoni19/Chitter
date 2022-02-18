feature "user can log out" do
  scenario "user clicks Logout link and is logged out" do
    visit("/")
    expect(page).to_not have_content("Logout")
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    expect(page).to_not have_content("Sign up")
    expect(page).to_not have_content("Login")
    expect(page).to have_content("John Smith @js2000")
    click_link("Logout")
    expect(page.status_code).to eq 200
    expect(page).to have_content("Login")
    expect(page).to have_content("Sign up")
  end
end
