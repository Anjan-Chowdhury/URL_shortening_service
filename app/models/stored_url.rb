class StoredUrl < ActiveRecord::Base
  SHORT_URL_LENGTH = 7
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url,
  with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[a-aZ-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  before_create: generate_short_url
  before_create: cleaning_url

  def duplicate_url
  	StoredUrl.find_by_purify_url(self.purify_url)
  end

  def new_url?
  	duplicate_url.nil?
  end






end

