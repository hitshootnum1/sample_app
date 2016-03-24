class EntriesController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]
	
	def show
		#debugger
		#ahihi.ahihi
		@comment = Comment.new
		@entry = Entry.find(params[:id])
		#@comments = @micropost.comments.paginate(page: params[:page])
		@comments = Comment.where("entry_id = ?", params[:id]).hash_tree
		@user = current_user
		if @entry.nil?
			flash[:danger] = 'Entry not found!'
			redirect_to request.referrer
		end
	end

	def create
		@entry = current_user.entries.build(entry_params)
		if @entry.save
			flash[:success] = 'Entry created!'
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		if @entry.destroy
			flash[:success] = "Entry deleted"
    		redirect_to request.referrer || root_url
		end
	end

	private 
		def entry_params
			params.require(:entry).permit :content, :picture
		end

		def correct_user
			@entry = current_user.entries.find(params[:id])
			redirect_to root_url unless @entry.nil
		end

end
