feature 'delete a bookmark' do
  it 'can delete a bookmark' do
    visit('/bookmarks')
    add_bookmark(title: 'Google', url: 'http://www.google.com')
    add_bookmark(title: 'Netflix', url: 'http://www.netflix.com')
    first('.bookmark').click_button('delete')
    expect(page).to have_content('Netflix')
    expect(page).to have_no_content('Google')
  end
end
