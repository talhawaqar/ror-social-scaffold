require 'rails_helper'
# rubocop:disable Metrics/BlockLength
describe 'the process of frind request send and accept', type: :feature do
  it 'sign up a new user and login to show page' do
    DatabaseCleaner.start
    visit new_user_registration_path
    within('#new_user') do # creating first user
      fill_in 'user[name]', with: 'umair ahmad'
      fill_in 'user[email]', with: 'umair1.1ahmad@gmail.com'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
    end
    click_button 'commit'
    expect(page).to have_content 'successfully'

    find(:xpath, "//a[@href='/users/sign_out']").click

    visit new_user_registration_path
    within('#new_user') do # creating second user
      fill_in 'user[name]', with: 'talha waqar'
      fill_in 'user[email]', with: 'talha@gmail.com'
      fill_in 'user[password]', with: '123456'
      fill_in 'user[password_confirmation]', with: '123456'
    end
    click_button 'commit'
    expect(page).to have_content 'successfully'

    find(:xpath, "//a[@href='/users/sign_out']").click

    visit user_session_path

    expect(page).to have_content('Email')

    within('#new_user') do # first user login
      fill_in 'user[email]', with: 'umair1.1ahmad@gmail.com'
      fill_in 'user[password]', with: '123456'
    end
    click_button 'Log in'

    visit users_path

    click_on('Send Request')
    find(:xpath, "//a[@href='/users/sign_out']").click

    visit user_session_path

    expect(page).to have_content('Email')

    within('#new_user') do # second user login
      fill_in 'user[email]', with: 'talha@gmail.com'
      fill_in 'user[password]', with: '123456'
    end
    click_button 'Log in'
    visit users_path

    click_on('Accept Request')
    expect(page).to have_content('Unfriend')

    DatabaseCleaner.clean
  end
end
# rubocop:enable Metrics/BlockLength
