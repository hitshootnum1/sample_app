class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    if !params[:search].nil?
      @users = User.where("name like ? ", "%#{params[:search][:user_name]}%")
                .paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end
  
  def show
    @user = User.find(params[:id])
    #@microposts = @user.microposts.paginate page: params[:page]
    @entries = @user.entries.paginate page: params[:page]
  end
  
  def new
    @user = User.new
    @user.address = Address.new
  end
  
  def create
    #debugger
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      if address_params?
        @user.update_attributes(address_attributes: address_params)
        #@user.save
        flash[:success] = 'updated address'
      end
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation)
  end  

  def address_params
    params.require(:user).require(:address_attributes).permit :city, :district, :street
  end

  def address_params?
    !params[:user][:address_attributes].nil?
  end
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
    
  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
