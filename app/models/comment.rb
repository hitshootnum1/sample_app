class Comment < ActiveRecord::Base

	acts_as_tree order: 'created_at DESC'

	belongs_to :micropost
	belongs_to :user

	
	#default_scope -> {order(created_at: :desc)}

	validates :content, presence: true, length: {maximum: 140}
	validates :user_id, presence: true
	validates :micropost_id, presence: true

end
