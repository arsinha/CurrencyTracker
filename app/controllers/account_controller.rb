class AccountController < ApplicationController

	def index
	end

  def login
	  if request.post?
		  begin
	      @user = User.find_by_name(params[:name])
        puts Digest::MD5.hexdigest(params[:password])
        if Digest::MD5.hexdigest(params[:password]) == @user[:password]
          session[:user_id] = @user[:id]
          redirect_to('/', :notice => 'You successfully logged in') and return
        end
			  redirect_to({}, :alert => 'Wrong password') and return
		  rescue ActiveRecord::RecordNotFound # user not found
			  redirect_to({}, :alert => 'Such login not exists') and return
		  rescue # some error
			  redirect_to({}, :alert => 'Unexpected error, try again') and return
		  end

	  end

  end

  def logout
	  if request.post?
		  reset_session
		  redirect_to(:action=>:login, :notice => 'You successfully logged out') and return
	  end
	  redirect_to :action => :index
  end

	def register
		if request.post?
			session[:params] = params
			name = params[:name].strip
			redirect_to({}, :alert => 'Login should not be empty, try again') and return if name.empty?
			redirect_to({}, :alert => 'Such user already exists, try another one') and return if User.find_by_name(name)
			password = params[:password].strip
			olso_password = params[:olso_password].strip
			redirect_to({}, :alert=>'Password should not be empty, try again') and return if password.empty?
			redirect_to({}, :alert=>"Passwords does not match, try again") and return if password != olso_password

			user = User.new({:name=>name, :password=>password})
			if user.save
        session[:user_id] = user[:id]
				redirect_to('/', :notice=>'You successfully registered and logged in') and return
			else
				redirect_to({}, :notice=>user.errors.to_s) and return
			end
		end
		@params = session[:params] || {}
		session[:params] = nil
	end

end
