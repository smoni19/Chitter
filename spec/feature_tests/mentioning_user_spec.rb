feature "user can tag a user in a Peep" do
  scenario "if user places an @ before a username, it becomes a link and clicking that link takes user to that tagged users profile" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    click_link("Logout")
    signup("Jane Smith", "janey12", "jane_smith@example.com", "1234")
    post_peep("Hi @js2000")
    click_link("@js2000")
    expect(page.status_code).to eq 200
    expect(page).to have_current_path("/users/js2000")
  end
end
