module CommentsHelper
	def comments_tree_for(comments)
	    comments.map do |comment, nested_comments|
	      prefix = render(comment) 
	      suffix = ''
	      if nested_comments.size > 0 
	       suffix = content_tag(:div, comments_tree_for(nested_comments), class: "replies")
	      end
	      prefix << suffix
	    end.join.html_safe
  	end

  	def comments_rescusion comments
  		
  	end
end
