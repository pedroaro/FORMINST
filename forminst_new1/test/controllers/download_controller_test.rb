require 'test_helper'

class DownloadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get download_index_url
    assert_response :success
  end

  test "should get zip" do
    get download_zip_url
    assert_response :success
  end

  test "should get pdf" do
    get download_pdf_url
    assert_response :success
  end

  test "should get doc" do
    get download_doc_url
    assert_response :success
  end

end
