require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :method_override

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
    Bookmark.create(url: params[:url], title: params[:title])
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
end
