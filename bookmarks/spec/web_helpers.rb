def add_bookmark(title:, url:)
  click_link('Add bookmark')
  fill_in 'url', with: url
  fill_in 'title', with: title
  click_button 'Submit'
end
