require 'comment'

describe Comment do
  describe '.create' do
    it 'queries the database with an insertion' do
      expect(DatabaseConnection).to receive(:query).with("INSERT INTO comments(content, bookmark_id) VALUES ('a comment', 1)")
      Comment.create(content: "a comment", bookmark_id: 1)
    end

    it 'stores and retrieves comments in the database' do
      bookmark = DatabaseConnection.query("INSERT INTO bookmarks(title, url) VALUES ('title','url') RETURNING id")
      bookmark_id = bookmark[0]['id']
      Comment.create(content: "a comment", bookmark_id: bookmark_id)
      expect(Comment.find(bookmark_id).first).to eq "a comment"
    end
  end 
end