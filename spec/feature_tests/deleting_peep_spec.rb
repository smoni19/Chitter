require "feature_tests/helper_methods/login"

feature "users can delete a Peep" do
  scenario "users post a Peep and the Peep is deleted when user clicks the delete button associated with that Peep" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("This is a test peep")
    click_button("Delete")
    expect(page).not_to have_content("This is a test peep")
  end
end
