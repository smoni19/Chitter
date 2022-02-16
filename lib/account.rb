require 'pg'

class Account

  attr_reader :name, :username, :email
  @live_db = PG.connect(dbname: 'chitter')
  @test_db = PG.connect(dbname: 'chitter_test')
  @sign_up = "INSERT INTO users (name, username, email, password) VALUES($1, $2, $3, $4) RETURNING id, name, username, email;"

  def initialize(name:, username:, email:)
    @name = name
    @username = username
    @email = email
  end

  def self.create(name:, username:, email:, password:)
    ENV['ENVIRONMENT'] == 'test' ? connection = @test_db : connection = @live_db
    result = connection.exec_params(@sign_up, [name, username, email, password])
    Account.new(name: result[0]['name'], username: result[0]['username'], email: result[0]['email'])
  end

end
