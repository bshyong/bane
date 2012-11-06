require 'spec_helper'

describe "TestCases" do
  describe "Visit home page" do
    it "should have response of 200" do
      get root_path
      response.status.should be(200)
    end
  end

  describe "Take user input" do
    it "should create a CitationHistory" do
      visit root_path
      fill_in "input", :with => "test input"
      click_button "Submit"
      page.find("#output").should have_content("Error occurred!")
      page.find("#input").should have_content("test input")
      CitationHistory.last.input.should eq("test input")
    end

    it "should display input and output" do
      visit root_path
      fill_in "input", :with => "test input"
      click_button "Submit"
      page.find("#output").should have_content("Error occurred!")
      page.find("#input").should have_content("test input")
    end
  end

  describe "Test sample cases" do
    
  end

end
