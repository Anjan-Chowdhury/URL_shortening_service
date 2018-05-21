require 'rails_helper'

RSpec.describe ShortedUrlsController, type: :controller do


	describe "create" do
		let!(:url) {FactoryGirl.create(:stored_url, :original_url => "facebook.com")}
		it "positive case" do
			  
			expect do
				post :create, original_url: "google.com"
			end.to change(StoredUrl, :count).by(1)
		end

		it "negative case" do
			expect do
				post :create, original_url: "google"
			end.to change(StoredUrl, :count).by(0)
		end
	end

	describe "show" do
		let(:url) {FactoryGirl.create(:stored_url, :original_url => "yahoo.com")}
		it "positive" do
			get :show, id: url.id
			expect(assigns(:url)).to eq(url)
		end

		it "negative" do
			get :show, id: "sadas"
			expect(assigns(:url)).to eq(nil)
		end
	end

	describe "index" do
		let!(:url_1) {FactoryGirl.create(:stored_url, :original_url => "yatra.com")}
		let!(:url_2) {FactoryGirl.create(:stored_url, :original_url => "goomo.com")}
		it "positive" do
			get :index
			expect(assigns(:urls)).to eq([url_1, url_2])
		end
		it "negative" do
			get :index
			expect(assigns(:url)).to eq(nil)
		end
	end

end
