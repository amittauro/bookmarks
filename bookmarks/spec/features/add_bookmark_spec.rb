feature 'Adding a bookmark' do
  scenario 'user adds a bookmark' do
    visit('/bookmarks')
    click_link('Add bookmark')
    fill_in 'url', with: 'http://www.imdb.com'
    click_button 'Submit'
    expect(page).to have_content('http://www.imdb.com')
  end
end
