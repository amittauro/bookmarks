class Comment
  def self.create(content:, bookmark_id:)
    DatabaseConnection.query("INSERT INTO comments(content, bookmark_id) VALUES ('#{content}', #{bookmark_id})")
  end

  def self.find(bookmark_id)
    response = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id=#{bookmark_id}")
    response.map { |comment| comment['content'] }
  end
end
