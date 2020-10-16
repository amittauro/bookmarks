require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require_relative './database_setup'
require 'pry'

class BookmarkManager < Sinatra::Base

  enable :method_override, :sessions
  register Sinatra::Flash

  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all

    erb :'bookmarks/index'
  end

  get '/add_bookmark' do
    erb :'bookmarks/add_bookmark'
  end

  post '/add_bookmark' do
    flash[:invalid_url] = 'Invalid URL!' unless Bookmark.create(url: params[:url], title: params[:title])

    redirect '/bookmarks'
  end

  delete '/delete_bookmark/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/update_bookmark/:id' do
    @bookmark_id = params[:id]
    @bookmark = Bookmark.find(params[:id])
    erb :'bookmarks/update_bookmark'
  end

  patch '/update_bookmark/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comment' do
    @bookmark = Bookmark.find(params[:id])
    erb :'bookmarks/comment'
  end

  post '/bookmarks/:id/comment' do
    Comment.create(content: params[:comment], bookmark_id: params[:id])
    # DatabaseConnection.query("INSERT INTO comments(content, bookmark_id) VALUES ('#{params[:comment]}', #{params[:id]})")
    redirect '/bookmarks'
  end
end
