require 'json'
class FacebooksController < ApplicationController
  # GET /facebooks
  # GET /facebooks.xml
  SITE_URL="http://localhost:3000/"
  def index
    if session['access_token']
      @face='You are logged in! <a href="facebooks/logout">Logout</a>'
    else
      @face='<a href="facebooks/login">Login</a>'
    end
  end

  def login
	# generate a new oauth object with your app data and your callback url
		session['oauth'] = Koala::Facebook::OAuth.new(Facebook::APP_ID, Facebook::APP_SECRET, SITE_URL + 'facebooks/callback/')
    #Koala::Facebook::OAuth.new(oauth_callback_url).
		
		# redirect to facebook to get your code
		redirect_to session['oauth'].url_for_oauth_code(:permissions =>'read_friendlists,friends_checkins,user_checkins,friends_location')

  end

  def logout
    session['oauth'] = nil
    session['access_token'] = nil
    redirect_to '/facebooks/index'
  end

	#method to handle the redirect from facebook back to you
	def callback
		#get the access token from facebook with your code
		session['access_token'] = session['oauth'].get_access_token(params[:code])
		redirect_to '/facebooks/menu'
	end

  def menu
     @ok="you are welcome"
     if session['access_token']
       @face='You are logged in! <a href="/facebooks/logout">Logout</a>'
      @graph = Koala::Facebook::API.new(session["access_token"])
#       @graph = Koala::Facebook::API.new(session["oauth_token"]) 
#              permissions = @graph.get_connections('me','permissions')
      
      user_details = @graph.get_object('me')
      @user = User.new(user_details)
      friendlist = @graph.get_connections('me','friends',:fields=>"name,gender,relationship_status,hometown")
      friend_list= Array.new()
      friendlist.each do |friend_detail|
        print friend_detail
        @friend = Friend.new(friend_detail)
        friend_list << @friend
      end
      @user.friends_list(friend_list)
      
      print "size is "
      print @user.get_friends_list.size
      
      @user.generate_stats
     else
       @face='<a href="/facebooks/login">Login</a>'
     end

  end
  
  

end
