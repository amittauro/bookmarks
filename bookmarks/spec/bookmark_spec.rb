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

    it 'does not add an invalid bookmark to the database' do
      expect(Bookmark.create(url: 'not an url', title: 'IMDB')).to be_falsey
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.valid?' do
    it 'returns true for valid url' do
      expect(Bookmark.valid?('http://www.imdb.com')).to be_truthy
    end

    it 'returns false for invalid url' do
      expect(Bookmark.valid?('not an url')).to be_falsey
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

  describe '.comments' do
    it 'returns an array of comments as strings for the bookmark instance' do
      Bookmark.create(url: 'http://www.imdb.com', title: 'IMDB')
      bookmark = Bookmark.all.first
      DatabaseConnection.query("INSERT INTO comments (content, bookmark_id) VALUES ('MOVIES!', #{bookmark.id}), ('I love movies!', #{bookmark.id})")

      expect(bookmark.comments).to be_instance_of(Array)
      expect(bookmark.comments).to all(be_instance_of(String))
      expect(bookmark.comments.first).to eq 'MOVIES!'
    end
  end
end
