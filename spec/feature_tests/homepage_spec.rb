feature "user visits the homepage" do
  scenario "users visiting the homepage can see Home, Login and Signup buttons" do
    visit("/")
    expect(page.status_code).to eq 200
    expect(page).to have_content "Home"
    expect(page).to have_content "Login"
    expect(page).to have_content "Sign up"
  end
end
