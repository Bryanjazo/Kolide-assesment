class Api::PostsController < ApplicationController
  before_action :set_api_post, only: [:show, :update, :destroy]

 # Link: https://api.hatchways.io/assessment/solution/posts?tags=history,tech&sortBy=likes&direction=desc
  def get_posts
    # retrieves all correct paramaters and places them in a variablee
    tags = params[:tags]
    sortBy = params[:sortBy]
    direction = params[:direction]

    # validates the sort paramaters to check if its included or not
    sortByValues = ["id","author","authorId","likes","popularity","reads","tags"]
    directionValues = ["asc", "desc"]
    response = Api::Post.fetch_posts(tags, sortBy, direction)
    

    Rails.cache.fetch("{#cache_key_with_version}/
      get_posts", expries_in: 60.minutes) do 
      Api::Post.fetch_posts(tags, sortBy, direction)
    end

  

    
    if !sortByValues.include?(sortBy)
      render json: {
        status: 400,
        error: "sortBy parameter is invalid"
      }
    end
    if !directionValues.include?(direction)
      render json: {
        status: 400,
        error: "sortBy parameter is invalid"
      }
    end

  
  if response.code === 200
    render json: response
  elsif response.code === 400
    render json: response
  end
  
end

# Single tag search only not using other queries can be called with multiple tags.

def get_post_by_one_tag
  # Finding tag paramaters 
  tags = params[:tags]
  # Making a call to a instance method in the models section to fetch the correct data
  response = Api::Post.fetch_posts_by_tag_only(tags)

  # Caching search for a time length of 60 minutes 
  Rails.cache.fetch("{#cache_key_with_version}/
    get_post_by_one_tag", expries_in: 60.minutes) do 
    Api::Post.fetch_posts_by_tag_only(tags)
  end

  # if the response is 200/correct render posts
  if response.code === 200 
    render json: response
  else
    render json: {
      error: 'Tags parameter is required'
    }
  end

end


end
