feature "user can post Peep" do
  scenario "users fill out peep form and click Post peep and have peep appear on page" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("This is a test peep")
    expect(page.status_code).to eq 200
    expect(page).to have_content("John Smith @js2000")
    expect(page).to have_content("This is a test peep")
  end
end
