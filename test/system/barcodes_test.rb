require "application_system_test_case"

class BarcodesTest < ApplicationSystemTestCase
  setup do
    @barcode = barcodes(:one)
  end

  test "visiting the index" do
    visit barcodes_url
    assert_selector "h1", text: "Barcodes"
  end

  test "should create barcode" do
    visit barcodes_url
    click_on "New barcode"

    fill_in "Name", with: @barcode.name
    fill_in "Value", with: @barcode.value
    click_on "Create Barcode"

    assert_text "Barcode was successfully created"
    click_on "Back"
  end

  test "should update Barcode" do
    visit barcode_url(@barcode)
    click_on "Edit this barcode", match: :first

    fill_in "Name", with: @barcode.name
    fill_in "Value", with: @barcode.value
    click_on "Update Barcode"

    assert_text "Barcode was successfully updated"
    click_on "Back"
  end

  test "should destroy Barcode" do
    visit barcode_url(@barcode)
    click_on "Destroy this barcode", match: :first

    assert_text "Barcode was successfully destroyed"
  end
end
