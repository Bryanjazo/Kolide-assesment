class Api::Post < ApplicationRecord
require 'httparty'

    # fetches all posts with sortBy and direction 
    def self.fetch_posts(tags, sortBy, direction)
        url = "https://api.hatchways.io/assessment/solution/posts?tags=#{tags},tech&sortBy=#{sortBy}&direction=#{direction}"
        postsResponse = HTTParty.get(url)
    end


    
    # fetches posts by tag name only 
    def self.fetch_posts_by_tag_only(tag)

        url = "https://api.hatchways.io/assessment/solution/posts?tags=#{tag}"
        postsResponse = HTTParty.get(url)
    end
    
end
