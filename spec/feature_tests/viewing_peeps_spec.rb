feature 'user visits the peeps feed page' do
  scenario 'users visiting the peeps feed page can see all peeps' do
    visit('/peeps')
    expect(page).to have_content("Hobnobs are the best biscuit")
    expect(page).to have_content("Fun fact: the can opener was invented over 1000 years before the can")
    expect(page).to have_content("Ignorance, the root and stem of every evil. ― Plato")
  end
end
