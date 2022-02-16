require 'pg'

class Peep

  attr_reader :text
  @live_db = PG.connect(dbname: 'chitter')
  @test_db = PG.connect(dbname: 'chitter_test')
  @save_peep = "INSERT INTO peeps (text) VALUES($1) RETURNING id, text;"
  @get_peeps = "SELECT * FROM peeps;"

  def initialize(text:)
    @text = text
  end

  def self.create(text:)
    ENV['ENVIRONMENT'] == 'test' ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@save_peep, [text])
    Peep.new(text: result[0]['text'])
  end

  def self.all
    ENV['ENVIRONMENT'] == 'test' ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@get_peeps)
    result.map do |peep|
      Peep.new(text: peep['text'])
    end
  end

end
