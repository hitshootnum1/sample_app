class AddressesController < ApplicationController

	before_action :address_attributes, only: [:create, :update]

	def edit
		@user = User.find(params[:user_id])
		@address = Address.find(params[:id])
	end
	def new
		@address = Address.new
		@user = User.find(params[:user_id])
		@address.user = @user
	end

	def create
		@user = User.find(params[:user_id])
		@address = Address.new(address_attributes)
		@address.user = @user
		if @address.save
			flash[:info] = 'Address created'
			redirect_to root_url
		else
			flash[:danger] = 'Address was not created'
			redirect_to root_url
		end
	end

	def destroy
	end

	def update
		puts params
		@address = Address.find(params[:id])
		if @address.update_attributes(address_attributes)
			flash[:info] = 'Address updated'
			redirect_to @address.user
		else
			flash[:danger] = 'Update Address Error'
			redirect_to root_url
		end
	end

	private
		def address_attributes
			params.require(:address).permit :city, :district, :street
		end
end
