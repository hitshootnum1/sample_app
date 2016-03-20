class UsersController < ApplicationController
  
  def index
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	#debugger
  end

  def create
  	@user = User.new(get_user_params)
  	if @user.save
      log_in @user
  		flash[:success] = 'Welcom to Sample App!'
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  private 
  	def get_user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
