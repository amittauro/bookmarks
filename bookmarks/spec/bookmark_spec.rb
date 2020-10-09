require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      conn = PG.connect( dbname: 'bookmark_manager_test' )
      conn.exec "INSERT INTO bookmarks(url) VALUES('http://www.makersacademy.com'),
      ('http://www.askjeeves.com'), ('http://www.twitter.com'), ('http://www.google.com')"
      bookmarks = Bookmark.all
      expect(bookmarks).to include("http://www.makersacademy.com")
      expect(bookmarks).to include("http://www.askjeeves.com")
    end
  end

  describe '.create' do
    it 'can add a bookmark to the database' do
      Bookmark.create('http://www.imdb.com')
      expect(Bookmark.all).to include('http://www.imdb.com')
    end
  end
end
