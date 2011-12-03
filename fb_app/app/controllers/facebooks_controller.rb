class FacebooksController < ApplicationController
  # GET /facebooks
  # GET /facebooks.xml
  APP_ID="151026538323899"
  APP_SECRET="67a39fee4e56b695409ac09882f57f43"
  APP_CODE="XXXX"
  SITE_URL="http://localhost:3000/"
  def index
    if session['access_token']
      @face='You are logged in! <a href="facebooks/logout">Logout</a>'
      # do some stuff with facebook here
      # for example:
      # @graph = Koala::Facebook::GraphAPI.new(session["access_token"])
      # publish to your wall (if you have the permissions)
      # @graph.put_wall_post("I'm posting from my new cool app!")
      # or publish to someone else (if you have the permissions too ;) )
      # @graph.put_wall_post("Checkout my new cool app!", {}, "someoneelse's id")
    else
      @face='<a href="facebooks/login">Login</a>'
    end
  end

  def login
	# generate a new oauth object with your app data and your callback url
		session['oauth'] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + 'facebooks/callback/')
    #Koala::Facebook::OAuth.new(oauth_callback_url).
		
		# redirect to facebook to get your code
		redirect_to session['oauth'].url_for_oauth_code(:permissions =>'read_friendlists,friends_checkins')

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

       # do some stuff with facebook here
       # for example:
       @graph = Koala::Facebook::GraphAPI.new(session["access_token"])
              permissions = @graph.get_connections('me','permissions')
       print permissions
#       friendlist = @graph.get_connections('me','friends')
#       print friendlist
#       @likes = @graph.get_connections("me", "likes")
#       
#       print @likes

      my =  @graph.get_object('660163880')
      print my
#@rest = Koala::Facebook::API.new(session['access_token'])
#
#      me = @rest.fql_query("select name from user where uid = 2905623")
#      print me
       # publish to your wall (if you have the permissions)
       # @graph.put_wall_post("I'm posting from my new cool app!")
       # or publish to someone else (if you have the permissions too ;) )
       # @graph.put_wall_post("Checkout my new cool app!", {}, "someoneelse's id")
     else
       @face='<a href="/facebooks/login">Login</a>'
     end

  end
end