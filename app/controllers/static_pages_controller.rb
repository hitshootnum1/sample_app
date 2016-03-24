class StaticPagesController < ApplicationController
  
  def home
  	if logged_in?
      @entry = current_user.entries.build
      @feed_items = current_user.get_entry_feed.paginate(page: params[:page])
    else
      @feed_items = Entry.all.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
end
