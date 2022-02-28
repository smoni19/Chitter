require "feature_tests/helper_methods/login"
require "feature_tests/helper_methods/signup"
require "feature_tests/helper_methods/post_peep"

feature "users can edit a Peep" do
  scenario "users post a Peep and can edit the Peep when user clicks the edit button associated with that Peep" do
    signup("John Smith", "js2000", "js2000@test.com", "1234")
    post_peep("This is a test peep")
    click_button("Edit")
    fill_in(:edited_text, with: "This is an edited Peep")
    click_button("Save Peep")
    expect(page.status_code).to eq 200
    expect(page).to have_content("Edited")
    expect(page).to have_content("This is an edited Peep")
  end
  
end
