require 'rails_helper'

describe "user login" do
  it "allows returning user to login" do
    user = create(:user)

    visit root_path

    click_button "Log in"

    expect(current_path).to eq("/login")

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Log in"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_button("Log out")
    expect(page).to_not have_button("Log in")

    visit root_path

    expect(page).to have_button("Log out")
    expect(page).to_not have_button("Log in")
    expect(page).to_not have_link("Register")
  end

  it "allows user to logout" do
    user = create(:user)

    visit root_path

    click_button "Log in"

    expect(current_path).to eq("/login")

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button "Log in"

    expect(current_path).to eq("/dashboard")

    click_button "Log out"

    expect(current_path).to eq("/")
    expect(page).to_not have_button("Log out")
    expect(page).to have_button("Log in")
    expect(page).to have_link("Register")
  end

  it "does not allow user to login with bad credentials" do
    user = create(:user)

    visit root_path

    click_button "Log in"

    expect(current_path).to eq("/login")

    fill_in :email, with: ""
    fill_in :password, with: user.password

    click_button "Log in"

    expect(page).to have_content("Sorry, your credentials are bad")
    expect(current_path).to eq("/login")

    fill_in :email, with: user.email
    fill_in :password, with: "123"

    click_button "Log in"

    expect(page).to have_content("Sorry, your credentials are bad")
    expect(current_path).to eq("/login")
  end
end
