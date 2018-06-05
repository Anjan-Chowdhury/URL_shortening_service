class ShortedUrlsController < ApplicationController

	before_action :search_url, only: [:show, :clear]
	skip_before_filter :verify_authenticity_token

	def index
		@urls = StoredUrl.all
	end

	def new
		@url = StoredUrl.new
	end

	def show
		@url = StoredUrl.find_by_id(params[:id])
		if @url.present?
			@url_host = request.remote_ip
		   GetStat.new(@url_host, browser, @url).call
		end
	end

	def url_stat
  		@url = StoredUrl.find_by_id(params[:id])
    end

	def create
		@url = StoredUrl.new(url_params)
		@url.cleaning_url
		if @url.new_url?
			if @url.save
				#redirect_to shorted_urls_path(@url.short_url)
				redirect_to shorted_urls_path
			else
				flash[:error] = "somethis wrong here"
				render "new"
			end
		else
			flash[:notice] = "shortend url  already present in your database"
			#redirect_to shorted_url_path(@url.duplicate_urls.short_url)
			redirect_to shorted_urls_path
	    end		

	end

	def clear
		@url = search_url
		host = request.host_with_port
		@original_url = @url.purify_url
		@short_url = host + '/' + @url.short_url
	end

	def fet_origin_url
		fetch_url = search_url
		redirect_to fetch_url.purify_url
	end

	private


	def search_url
		@url = StoredUrl.find_by_short_url(params[:short_url])
	end

	def url_params
    	params.permit(:original_url)
	end

end
