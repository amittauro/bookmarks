feature 'validating urls submitted by user' do
  scenario 'user submits invalid url and sees an error page' do
    visit '/bookmarks'
    add_bookmark(title: 'IMDB', url: 'I HATE THIS TEST')
    expect(page).to have_content 'Invalid URL!'
  end
end
