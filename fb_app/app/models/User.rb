# To change this template, choose Tools | Templates
# and open the template in the editor.

class User 
 
  def initialize(hash)
    @friend_list = []
    @analytics = Analytics.new
    hash.each do |k,v|
      self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})  ## create the getter that returns the instance variable
      self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})  ## create the setter that sets the instance variable
    end
  end
  
  def friends_list(value)
    @friend_list = value
  end
  
  def get_friends_list
    @friend_list
  end
  
  def generate_stats
    @analytics.generate_stats(@friend_list, self)
  end
  def analytics
    @analytics
  end
end