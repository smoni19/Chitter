feature 'user visits the peeps feed page' do
  scenario 'users can click View peeps link and see all peeps on peeps feed page' do
    visit('/')
    click_link('View peeps')
    expect(page).to have_content("Hobnobs are the best biscuit")
    expect(page).to have_content("Fun fact: the can opener was invented over 1000 years before the can")
    expect(page).to have_content("Ignorance, the root and stem of every evil. ― Plato")
  end
end
