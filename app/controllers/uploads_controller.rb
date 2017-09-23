class UploadsController < ApplicationController
	def index
		@upload = Upload.new
	end

	def create
		@upload = Upload.new(upload_params)
		if @upload.save
			redirect_to @upload #render json: { message: "success", uploadId: @upload.id }, status: 200
		else
			render 'edit' #render json: { error: @upload.errors.full_messages.join(", ") }, status: 400
		end
	end

	def list
		uploads = []
		Upload.all.each do |upload|
			new_upload = {
				id: upload.id,
				name: upload.image_file_name,
				size: upload.image_file_size,
				src: upload.image(:thumb)
			}
			uploads.push(new_upload)
		end

		render json: { images: uploads }
	end

	def destroy
		@upload = Upload.find(params[:id])
		if @upload.destroy
			render json: { message: "file deleted from server" }
		else
			render json: { message: @image.errors.full_messages.join(", ") }
		end
	end

	def search
		#@upload = Upload.all
		@keyword = ''
		if params[:search] and /^[\w ]+$/.match(params[:search])
			@keyword = params[:search]
		end
		#@up = Upload.search @keyword, fields: [ :author, :title, :description, :editor] if ENV['ES']
		@up = Upload.search(title: @keyword).order("created_at DESC")
		@uploads = []
		@up.each do |u|
			@uploads.push(u)
		end
	end

	def show
		@upload = Upload.find(params[:id])
	end

	def show_thumb_page
		@upload = Upload.find(params[:id])
		data = open(@upload.get_thumb_page)
		send_file data, :filename => @upload.image_file_name, :disposition => 'inline'
	end

	private

	def upload_params
		params.require(:upload).permit(:image, :id, :title, :author, :editor, :description)
	end

end
