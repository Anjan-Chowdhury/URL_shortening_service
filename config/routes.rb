Rails.application.routes.draw do
  resources :shorted_urls
  root to: 'shorted_urls#new'
  get  '/shorted_urls/fetch_origin_url'
  get "/shorted_urls/url_stat"

end
