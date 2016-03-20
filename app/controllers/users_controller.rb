class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:update, :edit]
  before_action :correct_user, only: [:update, :edit]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update_attributes get_user_params
      flash.now[:success] = 'Information updated!'
      redirect_to @user
    else
      flash.now[:danger] = 'Cannot update information'
      render 'edit'
    end
  end

  private 
  	def get_user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'Please login to do this action!'
        redirect_to login_url
      end
    end

    def correct_user
      @user = current_user
      unless @user.id == params[:id]
        flash[:danger] = 'You are not authorized to do this action!'
        redirect_to root_url
      end
    end
end
