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

    # Seperating the fetch method in order to keep seperation of concerns 
    response = Api::Post.fetch_posts(tags, sortBy, direction)
    
    # caching in all of the posts for 60 minutes
    Rails.cache.fetch("{#cache_key_with_version}/
      get_posts", expries_in: 60.minutes) do 
      Api::Post.fetch_posts(tags, sortBy, direction)
    end


    if tags === ' ' 
      return render json: {
        status: 400,
        error: "Tag paramater must be valid"
      }
    end
  

    # conditional that checks if the params sort includes one of the words in the array
    if !sortByValues.include?(sortBy)
     return render json: {
        status: 400,
        error: "sortBy parameter is invalid"
      }
   
    end

    # conditional that checks if the params direction includes one of the words in the array
   if !directionValues.include?(direction)
    return render json: {
      status: 400,
      error: "sortBy parameter is invalid"
    }
  end

  # return response
  if response.code === 200
    return render json: response
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
 
  
  end

end


end
