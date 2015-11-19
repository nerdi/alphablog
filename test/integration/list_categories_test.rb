require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "books")
    @category2 = Category.create(name: "programming")
  end

  test "should show category listing" do
    get categories_path
    assert_template 'categories/index'
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category.name
  end
end
