require "test_helper"
class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username: "Dan", email: "dan@dan.com", password: "password", admin: true)
  end

  test "Should get categories index" do
    get :index
    assert_response :success
  end

  test "Should get new" do
    session[:user_id] = @admin_user.id
    get :new
    assert_response :success
  end

  test "Should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end
end
