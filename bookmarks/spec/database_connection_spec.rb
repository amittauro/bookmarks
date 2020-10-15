require_relative './../lib/database_connection'
require 'pry'

describe DatabaseConnection do
  describe '.setup' do
    it 'connects to the databse' do
      expect(PG).to receive(:connect).with dbname: 'bookmark_manager_test'
      DatabaseConnection.setup('bookmark_manager_test')
    end
  end

  describe '.query' do
    it 'can execute an SQL query such as SELECT * FROM TABLE' do
      connection = DatabaseConnection.setup('bookmark_manager_test')
      expect(connection).to receive(:exec).with 'SELECT * FROM bookmarks'
      output = DatabaseConnection.query("SELECT * FROM bookmarks")
    end

    it 'can execute an SQL query such as SELECT * FROM TABLE' do
      DatabaseConnection.setup('bookmark_manager_test')
      output = DatabaseConnection.query("SELECT * FROM bookmarks")
      expect(output).to be_an_instance_of(PG::Result)
    end
  end
end
