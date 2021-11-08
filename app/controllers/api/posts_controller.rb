class Api::PostsController < ApplicationController
  before_action :set_api_post, only: [:show, :update, :destroy]

 # Link: https://api.hatchways.io/assessment/solution/posts?tags=history,tech&sortBy=likes&direction=desc
  def get_posts
    
    tags = params[:tags]
    sortBy = params[:sortBy]
    direction = params[:direction]
    sortByValues = ["id","author","authorId","likes","popularity","reads","tags"]
    directionValues = ["asc", "desc"]

    response = Api::Post.fetch_posts(tags, sortBy, direction)
    
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

def get_post_by_one_tag
  tags = params[:tags]
  response = Api::Post.fetch_posts_by_tag_only(tags)
 
  if response.code === 200 
    render json: response
  else
    render json: {
      error: 'Tags parameter is required'
    }
  end

end


end
