require 'pg'

def reset_test_database
  connection = PG.connect(dbname: 'chitter_test')
  connection.exec("TRUNCATE peeps CASCADE")
  connection.exec("TRUNCATE users CASCADE")
end
