require 'pg'

class Peep

  attr_reader :text

  def initialize(text:)
    @text = text
  end

  def self.create(text:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'chitter_test') : connection = PG.connect(dbname: 'chitter')
    result = connection.exec_params('INSERT INTO peeps (text) VALUES($1) RETURNING id, text;', [text])
    Peep.new(text: result[0]['text'])
  end

  def self.all
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'chitter_test') : connection = PG.connect(dbname: 'chitter')
    result = connection.exec_params("SELECT * FROM peeps;")
    result.map do |peep|
      Peep.new(text: peep['text'])
    end
  end

end
