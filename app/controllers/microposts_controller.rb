class MicropostsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]
	
	def show
		#debugger
		#ahihi.ahihi
		@comment = Comment.new
		@micropost = Micropost.find(params[:id])
		#@comments = @micropost.comments.paginate(page: params[:page])
		@comments = Comment.hash_tree
		@user = current_user
		if @micropost.nil?
			flash[:danger] = 'Micropost not found!'
			redirect_to request.referrer
		end
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = 'Micropost created!'
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		if @micropost.destroy
			flash[:success] = "Micropost deleted"
    		redirect_to request.referrer || root_url
		end
	end

	private 
		def micropost_params
			params.require(:micropost).permit :content, :picture
		end

		def correct_user
			@micropost = current_user.microposts.find(params[:id])
			redirect_to root_url unless @micropost.nil
		end

end
