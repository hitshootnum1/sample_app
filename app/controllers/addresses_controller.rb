class AddressesController < ApplicationController

	def edit
		@user = User.find(params[:user_id])
		@address = Address.find(params[:id])
	end

	def create
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
