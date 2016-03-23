class Address < ActiveRecord::Base

	belongs_to :user

	validates :city, presence: true
	validates :district, presence: true
	validates :street, presence: true
	
end
