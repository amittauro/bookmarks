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
    # binding.pry
    if params[:url] =~ URI::regexp(['http', 'https'])
      Bookmark.create(url: params[:url], title: params[:title])
      redirect '/bookmarks'
    else
      flash[:invalid_url] = 'Invalid URL!'
      redirect '/bookmarks'
    end
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

  get '/bad_bookmark' do
    "Invalid URL!"
  end

  get '/flash-test' do
    flash[:test] = "Hello Flashy World!"
    # binding.pry
    erb :'bookmarks/flash-test'
  end
end
