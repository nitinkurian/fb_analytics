# To change this template, choose Tools | Templates
# and open the template in the editor.

class Analytics
  attr_accessor :gender_stats,:relationship_stats 
  def initialize
    @gender_stats = Hash.new(0) 
    @relationship_stats = Hash.new(0)
  end
  
  def generate_stats(friends_list)
    
    friends_list.each do |friend|
      @gender_stats[friend.gender]+=1
      @relationship_stats[friend.relationship_status]+=1
    end
    
  end
end
