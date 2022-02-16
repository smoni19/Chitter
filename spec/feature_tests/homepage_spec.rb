feature 'user visits the homepage' do
  scenario 'users visiting the homepage can see welcome message' do
    visit('/')
    expect(page.status_code).to eq 200
    expect(page).to have_content 'Welcome to Chitter!'
  end
end
