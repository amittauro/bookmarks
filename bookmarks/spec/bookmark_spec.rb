require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      conn = PG.connect( dbname: 'bookmark_manager_test' )
      conn.exec "INSERT INTO bookmarks(url) VALUES('http://www.makersacademy.com'),
      ('http://www.askjeeves.com'), ('http://www.twitter.com'), ('http://www.google.com')"
      bookmarks = Bookmark.all
      expect(bookmarks).to all(be_instance_of(Bookmark))
    end
  end

  describe '.create' do
    it 'can add a bookmark and title to the database' do
      Bookmark.create(url: 'http://www.imdb.com', title: 'IMDB')
      expect(Bookmark).to receive(:new).with(title: 'IMDB', url: 'http://www.imdb.com')
      Bookmark.all
    end
  end

  describe 'instance methods' do
    let(:bookmark) { Bookmark.new(title: 'IMDB', url: 'http://www.imdb.com') }
    
    it '.url returns the URL' do
      expect(bookmark.url).to eq 'http://www.imdb.com'
    end

    it '.title returns the title' do
      expect(bookmark.title).to eq 'IMDB'
    end
  end
end
