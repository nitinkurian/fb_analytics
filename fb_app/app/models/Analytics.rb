# To change this template, choose Tools | Templates
# and open the template in the editor.

class Analytics
  attr_accessor :gender_stats,:relationship_stats,:hometown_stats
  def initialize
    @gender_stats = Hash.new(0) 
    @relationship_stats = Hash.new(0)
    @hometown_stats = Hash.new(0)
  end
  
  def generate_stats(friends_list, user)
    
    friends_list.each do |friend|
      @gender_stats[friend.gender]+=1
      @relationship_stats[friend.relationship_status]+=1
      if user.hometown == friend.hometown
        @hometown_stats["Same Hometown"]+=1
      end
    end
    
  end
end
