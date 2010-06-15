require "test/test_helper"

class Admin::ResourcesHelperTest < ActiveSupport::TestCase

  include Admin::ResourcesHelper

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper

  def render(*args); args; end

  def test_display_link_to_previous
    @resource = Post
    params = { :action => "edit", :back_to => "/back_to_param" }
    self.expects(:params).at_least_once.returns(params)

    partial = "admin/helpers/resources/display_link_to_previous"
    options = { :message => "You're updating a Post." }

    assert_equal [ partial, options ], display_link_to_previous
  end

  def test_remove_filter_link
    output = remove_filter_link("")
    assert output.nil?
  end

  def test_build_list_when_returns_a_table

    model = TypusUser
    fields = %w( email role status )
    items = TypusUser.all
    resource = "typus_users"

    self.stubs(:build_table).returns("a_list_with_items")

    output = build_list(model, fields, items, resource)
    expected = "a_list_with_items"

    assert_equal expected, output

  end

  def test_build_list_when_returns_a_template

    model = TypusUser
    fields = %w( email role status )
    items = TypusUser.all
    resource = "typus_users"

    self.stubs(:render).returns("a_template")
    File.stubs(:exist?).returns(true)

    output = build_list(model, fields, items, resource)
    expected = "a_template"

    assert_equal expected, output

  end

end