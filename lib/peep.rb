require "pg"

class Peep

  attr_reader :text, :account_id, :id
  @live_db = PG.connect(dbname: "chitter")
  @test_db = PG.connect(dbname: "chitter_test")
  @save_peep = "INSERT INTO peeps (text, account_id) VALUES($1, $2) RETURNING id, text, account_id;"
  @get_peeps = "SELECT * FROM peeps;"

  def initialize(text:, account_id:, id:)
    @text = text
    @account_id = account_id
    @id = id
  end

  def self.create(text:, account_id:)
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@save_peep, [text, account_id])
    Peep.new(text: result[0]["text"], account_id: result[0]["account_id"], id: result[0]["id"])
  end

  def self.all
    ENV["ENVIRONMENT"] == "test" ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@get_peeps)
    result.map do |peep|
      Peep.new(text: peep["text"], account_id: peep["account_id"], id: peep["id"])
    end
  end

  def get_user_info
    Account.find(id: account_id)
  end
end
