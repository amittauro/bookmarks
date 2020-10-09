describe Bookmark, type: :feature do
  it 'retrieves bookmarks from SQL' do
    Bookmark.create('http://www.makersacademy.com')
    Bookmark.create('http://www.askjeeves.com')
    visit '/bookmarks'
    expect(page).to have_content("http://www.makersacademy.com")
    expect(page).to have_content("http://www.askjeeves.com")
  end
end
