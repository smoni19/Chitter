require 'peep'

describe Peep do
  describe '#all' do
    it 'returns all peeps' do
      peeps = Peep.all
      expect(peeps).to include("Hobnobs are the best biscuit")
      expect(peeps).to include("Fun fact: the can opener was invented over 1000 years before the can")
      expect(peeps).to include("Ignorance, the root and stem of every evil. ― Plato")
    end
  end
end
