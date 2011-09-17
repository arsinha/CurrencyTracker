class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :active_item?
  before_filter :check_login

	def set_active_item item
		@active_item = item
	end

	def active_item?(item)
		item.to_sym == @active_tab
	end

	def check_login
		if session[:user_id]
			begin
				@user = User.find(session[:user_id], :include => :countries)
			rescue ActiveRecord::RecordNotFound # user was deleted
				reset_session
				redirect_to({:controller => :account, :action => :login}, :alert => "You have been logged out due to unexpected error") and return
			end
		else
			@user = nil
		end
	end

end
