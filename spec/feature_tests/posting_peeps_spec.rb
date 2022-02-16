feature "user can post Peep" do
  scenario "users fill out peep form and click Post peep and have peep appear on page" do
    visit("/")
    fill_in("text", with: "This is a test peep")
    click_button("Post peep")
    expect(page).to have_content("This is a test peep")
  end
end
