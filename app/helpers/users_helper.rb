module UsersHelper
  
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def show_action_find_user
  	user_id = params[:id]
  	if user_id.to_i > 0
  		@user = User.find(user_id.to_i)
  	else
  		@user = User.friendly.find(user_id)
  	end
  end
end
