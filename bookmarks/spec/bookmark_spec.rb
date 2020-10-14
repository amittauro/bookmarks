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
      bookmark = Bookmark.all.first
      expect(Bookmark).to receive(:new).with(title: 'IMDB', url: 'http://www.imdb.com', id: "#{bookmark.id}")
      Bookmark.all
    end
  end

  describe 'instance methods' do
    let(:bookmark) { Bookmark.new(title: 'IMDB', url: 'http://www.imdb.com', id: '1') }

    it '.url returns the URL' do
      expect(bookmark.url).to eq 'http://www.imdb.com'
    end

    it '.title returns the title' do
      expect(bookmark.title).to eq 'IMDB'
    end
  end

  describe '.delete' do
    it 'can delete a bookmark' do
      Bookmark.create(url: 'http://www.imdb.com', title: 'IMDB')
      bookmark = Bookmark.all.first
      Bookmark.delete(bookmark.id)
      expect(Bookmark.all). to eq []
    end
  end

  describe '.update' do
    it 'can update a bookmark' do
      Bookmark.create(url: 'http://www.imdb.com', title: 'IMDB')
      bookmark1 = Bookmark.all.first
      Bookmark.update(id: bookmark1.id, title: 'IBM', url: 'http://www.ibm.com')
      bookmark2 = Bookmark.all.first
      expect(bookmark2.title).to eq('IBM')
      expect(bookmark1.id).to eq(bookmark2.id)
    end
  end

  describe '.find' do
    it 'can find a bookmark' do
      Bookmark.create(url: 'http://www.imdb.com', title: 'IMDB')
      Bookmark.create(url: 'http://www.netflix.com', title: 'Netflix')
      bookmark1 = Bookmark.all.first
      find_bookmark = Bookmark.find(bookmark1.id)
      expect(find_bookmark.title).to eq('IMDB')
    end
  end
end
