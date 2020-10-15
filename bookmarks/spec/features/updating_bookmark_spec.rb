feature 'updating bookmark' do
  it 'changes the title' do
    visit('/bookmarks')
    add_bookmark(title: 'IMDB', url: 'http://www.imdb.com')
    click_button('update')
    fill_in 'title', with: 'IBM'
    fill_in 'url', with: 'http://www.ibm.com'
    click_button('submit')
    expect(page).to have_content('IBM')
  end
end
