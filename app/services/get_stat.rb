class GetStat

  def initialize(host, url_browser, url)
  	@url_host = host
  	@url_browser = url_browser
  	@url = url
  end

  def call
  	save_status
  end

  private

  def save_status
  	@url_data = @url.url_infos.build(host: @url_host, browser_info: @url_browser.to_s, browser_platform: @url_browser.platform.to_s)
  	@url_data.save
  end

end