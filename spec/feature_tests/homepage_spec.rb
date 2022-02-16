feature 'user visits the homepage' do
  scenario 'users visiting the homepage can see welcome message' do
    visit('/')
    expect(page).to have_content 'Welcome to Chitter!'
  end
end
