require 'rails_helper'

RSpec.describe StoredUrl, type: :model do

  describe "" do
  	let(:url) {FactoryGirl.build(:stored_url)}
  	let!(:dup_url) {FactoryGirl.create(:stored_url)}

  	it "is valid with without original_url" do
  		url.original_url = nil 
  		expect(url).to_not be_valid
  	end

  	it "is valid with valid original_url" do
  		expect(url).to be_valid
  	end

  	it "is not be valid with wrong original_url format" do
  		url.original_url = "sfdfdsf"
  		expect(url).to_not be_valid
  	end


  	it "should generate short url" do
  		url.save
  		expect(url.short_url).to be_present
  	end


  	it "should fetch duplicate url" do
  		dup_url_obj = url.duplicate_url
  		expect(url).to be_present
  	end

  	it "should fetch duplicate url" do
  		url.purify_url = "facebook.com"
  		url_obj = url.new_url?
  		expect(url_obj).to eq(true)
  	end

  	it "should fetch duplicate url" do
  		url_obj = dup_url.new_url?
  		expect(url_obj).to eq(false)
  	end



  end
  
end

