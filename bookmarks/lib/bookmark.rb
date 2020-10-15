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
    DatabaseConnection.query("INSERT INTO bookmarks(title,url) VALUES('#{title}','#{url}')")
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id: ,title: ,url: )
    DatabaseConnection.query("UPDATE bookmarks SET id = '#{id}', url = '#{url}', title = '#{title}' WHERE id = '#{id}'")
  end

  def self.find(id)
    rs = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = '#{id}'")
    rs.map do |bookmark|
      new(title: bookmark["title"], url: bookmark["url"], id: bookmark["id"])
    end.pop
  end
end
