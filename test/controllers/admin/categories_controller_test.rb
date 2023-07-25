require 'test_helper'

class Admin::CategoriesControllerTest < TestBase
  setup do
    @user = create(:valid_user)
  end

  test "before_action authenticate redirects to new session" do
    post "/admin/categories"
    assert_redirected_to new_admin_session_path
  end

  test "POST#create before_action redirects to new session" do
    as @user
    post "/admin/categories", params: {
      category: {
        name: "pudge",
      }
    }
    assert_redirected_to admin_category_path(Category.last)
    assert_equal 1, Category.count
  end

  test "PATH#update with delete destroys the category" do
    category = create(:category, name: "old")

    assert_equal 1, Category.count

    as @user
    patch "/admin/categories/#{category.name}", params: {
      category: {
        name: "new"
      }
    }

    assert_equal 1, Category.count
    assert_equal "new", Category.last.name
    assert_redirected_to admin_category_path(Category.last)
  end

  test "PATH#update with 'cancel'" do
    category = create(:category, name: "old")

    assert_equal 1, Category.count

    as @user
    patch "/admin/categories/#{category.name}", params: {
      cancel: 1,
    }

    assert_equal 1, Category.count
    assert_equal "old", Category.last.name
    assert_redirected_to admin_category_path(Category.last)
  end

  test "POST#update_series_positions updates positions" do
    category = create(:category, name: "old")

    assert_equal 1, Category.count

    as @user
    patch "/admin/categories/#{category.name}", params: {
      delete: 1,
    }

    assert_equal 0, Category.count
    assert_redirected_to admin_root_path
  end
end
