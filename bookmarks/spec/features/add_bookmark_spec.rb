feature 'Adding a bookmark' do
  
  before do
    visit('/bookmarks')
    add_bookmark(title: 'IMDB', url: 'http://www.imdb.com')
  end
  
  scenario 'user adds a single bookmark' do
    expect(page).to have_link('IMDB', href:'http://www.imdb.com')
  end

  scenario 'user adds multiple bookmarks' do
    add_bookmark(title: 'Rotten Tomatoes', url: 'http://www.rottentomatoes.com')
    expect(page).to have_link('IMDB', href:'http://www.imdb.com')
    expect(page).to have_link('Rotten Tomatoes', href:'http://www.rottentomatoes.com')
  end
end
