feature 'commenting on bookmarks' do
  scenario 'enter a comment and see it displayed below the bookmark' do
    visit '/bookmarks'
    add_bookmark(title: 'IMDB', url: 'http://www.imdb.com')
    click_button "Add Comment"
    expect(page).to have_content "Comment on IMDB"
    fill_in "comment", with: "MOVIES!"
    click_button "Submit"
    expect(page).to have_content "MOVIES!"
    expect(current_path).to eq '/bookmarks'
  end
end
