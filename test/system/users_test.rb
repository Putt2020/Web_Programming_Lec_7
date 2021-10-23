require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @post = posts(:one)
    @post2 = posts(:one)
    @follow = follows(:two)
  end

  test "login fail" do
    visit main_url
    fill_in "Email", with: @user2.email
    fill_in "Password", with: "wrongPassword"

    click_on "Login"
    assert_text "Either email or password is incorrect :)"
  end

  test "login success" do
    visit main_url
    fill_in "Email", with: @user2.email
    fill_in "Password", with: "password"

    click_on "Login"
    assert_text "FEED"
  end

=begin
  test "create post" do
    visit main_url
    fill_in "Email", with: @user2.email
    fill_in "Password", with: "password"
    click_on "Login"

    click_on "New Post"

    fill_in "Msg", with: "test_message"

    click_on "Create Post"
    assert_text "Post was successfully created."
  end
=end

  test "like post" do
    visit main_url
    fill_in "Email", with: @user2.email
    fill_in "Password", with: "password"
    click_on "Login"

    click_on "New Post"
    fill_in "Msg", with: "test_message"
    click_on "Create Post"
    click_on "Like", match: :first
    click_on "Log Out"

    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_on "Login"

    click_on "Like", match: :first
    assert_text "2 Users like this post"

    click_on "Unlike", match: :first
    assert_text "1 Users like this post"
    click_on "1 Users like this post", match: :first
    assert_text @user2.name

    click_on "Like", match: :first
    click_on "Users like this post", match: :first
    assert_text @user.name
    assert_text @user2.name
    click_on @user2.name
    click_on "Users like this post", match: :first
    assert_text @user.name
    assert_text @user2.name
  end

=begin
  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Email", with: @user.email
    fill_in "Name", with: @user.name
    fill_in "Password", with: "password"
    click_on "Submit"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Email", with: @user.email
    fill_in "Name", with: @user.name
    fill_in "Password", with: "password"
    click_on "Submit"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
=end

end
