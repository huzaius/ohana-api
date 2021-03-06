require 'rails_helper'

feature 'Update contact' do
  background do
    location = create(:location)
    location.contacts.create!(attributes_for(:contact))
    login_super_admin
    visit '/admin/locations/vrs-services'
    click_link 'Moncef Belyamani'
  end

  scenario 'with valid values' do
    fill_in 'contact_department', with: 'CFO'
    fill_in 'contact_email', with: 'foo@bar.com'
    fill_in 'contact_name', with: 'Monfresh'
    fill_in 'contact_title', with: 'CFO'

    click_button I18n.t('admin.buttons.save_changes')

    expect(page).to have_content 'Contact was successfully updated.'
    expect(find_field('contact_department').value).to eq 'CFO'
    expect(find_field('contact_email').value).to eq 'foo@bar.com'
    expect(find_field('contact_name').value).to eq 'Monfresh'
    expect(find_field('contact_title').value).to eq 'CFO'
  end

  scenario 'with invalid values' do
    fill_in 'contact_email', with: 'foobar'
    fill_in 'contact_name', with: ''

    click_button I18n.t('admin.buttons.save_changes')

    expect(page).to have_content 'is not a valid email'
    expect(page).to have_content "Name can't be blank for Contact"
  end
end
