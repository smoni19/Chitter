feature "user can create a hashtag" do
  scenario "if user places a # before a word, it becomes a link and clicking that link takes user to a page featuring all those hashtags" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("This is a test #peep")
    click_link("peep")
    expect(page.status_code).to eq 200
    expect(page).to have_current_path("/hashtag/peep")
    expect(page).to have_content("This is a test #peep")
  end
end
