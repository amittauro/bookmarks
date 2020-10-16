require "pg"
require_relative './database_connection'

class Bookmark
  attr_reader :title, :url, :id

  def initialize(title:, url:, id:)
    @title = title
    @url = url
    @id = id
  end

  def self.all
    rs = DatabaseConnection.query("SELECT * FROM bookmarks")
    rs.map do |bookmark|
      new(title: bookmark["title"], url: bookmark["url"], id: bookmark["id"])
    end
  end

  def self.create(title:, url:)
    if valid?(url)
      DatabaseConnection.query("INSERT INTO bookmarks(title,url) VALUES('#{title}','#{url}')")
    end
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id:, title:, url:)
    DatabaseConnection.query("UPDATE bookmarks SET id = '#{id}', url = '#{url}', title = '#{title}' WHERE id = '#{id}'")
  end

  def self.find(id)
    bookmark = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = '#{id}'").first
    new(title: bookmark["title"], url: bookmark["url"], id: bookmark["id"])
  end

  def self.valid?(url)
    url =~ URI::regexp(['http', 'https'])
  end

  def comments
    response = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id=#{@id}")
    response.map { |comment| comment["content"] }
  end
end
