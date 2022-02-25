feature "user can post Peep" do
  scenario "users can post a Peep whilst on index, their profile or hashtag page" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("This is a test peep")
    expect(page.status_code).to eq 200
    expect(page).to have_content("John Smith @js2000")
    expect(page).to have_content("This is a test peep")
  end

  scenario "user cannot post a Peep whilst on another user's page" do
    signup("Jane Smith", "janey12", "jane_smith@example.com", "1234")
    click_link("Logout")
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    visit("/janey12")
    expect(page).not_to have_content("Message")
    expect(page).not_to have_link("Peep!")
  end

end
