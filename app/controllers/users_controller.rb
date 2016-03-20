class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:update, :edit, :destroy]
  before_action :correct_user, only: [:update, :edit]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
    store_location
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.get_user_by_id(params[:id])
  end

  def create
  	@user = User.new(get_user_params)
  	if @user.save
      log_in @user
  		flash[:success] = 'Welcom to Sample App!'
  		redirect_to root_url
      activate_stuff
  	else
      flash[:danger] = 'Something wrong, please recreate new account'
  		render 'new'
  	end
  end

  def edit
    @user = User.get_user_by_id(params[:id])
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

  def destroy
    @user = User.get_user_by_id(params[:id])
    dup_user = @user.dup
    if @user.destroy
      flash[:success] = 'User has been deleted'
      redirect_back_or root_url
    else
      flash[:danger] = 'Cannot delete user'
      redirect_back_or root_url
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
      unless @user.id != params[:id]
        flash[:danger] = 'You are not authorized to do this action!'
        redirect_to root_url
      end
    end

    def activate_stuff
      UserMailer.activate_account(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
    end

    def admin_user
      @current_user = current_user
      unless @current_user.admin
        flash[:danger] = 'You are not authorized to do this action!'
        redirect_to root_url
      end
    end
end
