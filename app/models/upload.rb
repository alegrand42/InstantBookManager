class Upload < ApplicationRecord

	if ENV["UPLOADS_PATH"]
		has_attached_file :image,  :path => "#{ENV["UPLOADS_PATH"]}/:year/:month/:day/:id/image/:filename", styles: { thumb: "120x120>" }, :url => "#{ENV["UPLOADS_PATH"]}/:year/:month/:day/:id/image/:filename", default_url: "/images/:style/missing.png"
	else
		has_attached_file :image, :path => "#{Rails.root}/public/system/:year/:month/:day/:id/image/:filename", styles: { thumb: "300x300>" }, :url => "/system/:year/:month/:day/:id/image/:filename", default_url: "/images/:style/missing.png"
	end

	Paperclip.interpolates :year do |attachment, style|
		attachment.instance.created_at.year
	end
	Paperclip.interpolates :month do |attachment, style|
		attachment.instance.created_at.month
	end
	Paperclip.interpolates :day do |attachment, style|
		attachment.instance.created_at.day
	end

	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	def get_upload_root
		if ENV["UPLOADS_PATH"]
			return ENV["UPLOADS_PATH"]
		end
		return "#{Rails.root}/public/system/#{created_at.year}/#{created_at.month}/#{created_at.day}/#{id}/image"
	end

	def get_thumb_page
		"#{get_upload_root}/#{image_file_name}"
	end

end
