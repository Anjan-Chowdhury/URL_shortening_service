class StoredUrl < ActiveRecord::Base
  SHORT_URL_LENGTH = 7

  has_many :url_infos
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url, with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
  #validates_format_of :original_url,
  #with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[a-aZ-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  before_create :crerate_optimize_url
  before_create :cleaning_url

  def crerate_optimize_url
  	#new_url = Random.new.bytes(6) + rand(100..10000).to_s
  	new_url = ([*('a'..'z'),*('0'..'9')]).sample(SHORT_URL_LENGTH).join
  	old_url = StoredUrl.where(short_url: new_url).last
  	if old_url.present?
  		self.crerate_optimize_url
  	else
  		self.short_url = new_url
  	end
  end

  def duplicate_url
  	StoredUrl.find_by_purify_url(self.purify_url)
  end

  def new_url?
  	duplicate_url.nil?
  end

  def cleaning_url
  	self.original_url.strip
  	#self.purify_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
  	self.purify_url = "http://#{self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")}"
  end





end

