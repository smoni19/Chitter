feature 'user visits the peeps feed page' do
  scenario 'users can click View peeps link and see all peeps on peeps feed page' do
    Peep.create(text: "Hobnobs are the best biscuit")
    Peep.create(text: "Fun fact: the can opener was invented over 1000 years before the can")
    Peep.create(text: "Ignorance, the root and stem of every evil. ― Plato")
    peeps = Peep.all
    visit('/')
    expect(page).to have_content("Hobnobs are the best biscuit")
    expect(page).to have_content("Fun fact: the can opener was invented over 1000 years before the can")
    expect(page).to have_content("Ignorance, the root and stem of every evil. ― Plato")
  end
end
