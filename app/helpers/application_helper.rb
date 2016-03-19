module ApplicationHelper

	BASE_TITLE = 'Ruby on Rails Tutorial Sample App'

	def full_title page_title = ''
		if !page_title.empty?
			page_title << ' | ' << BASE_TITLE
		end
		BASE_TITLE
	end
end
