require 'peep'

describe Peep do
  describe '#all' do
    it 'returns all peeps' do
      Peep.create(text: "Hobnobs are the best biscuit")
      Peep.create(text: "Fun fact: the can opener was invented over 1000 years before the can")
      Peep.create(text: "Ignorance, the root and stem of every evil. ― Plato")
      peeps = Peep.all
      expect(peeps.length).to eq 3
      expect(peeps[0].text).to eq "Hobnobs are the best biscuit"
      expect(peeps[1].text).to eq "Fun fact: the can opener was invented over 1000 years before the can"
      expect(peeps[2].text).to eq "Ignorance, the root and stem of every evil. ― Plato"
    end
  end
end
