class LikesController < ApplicationController
  def create
    @like=current_user.likes.new(like_params)
    @post = Post.find(params.dig(:like, :post_id))
    

    if !@like.save
      flash[:alert]="You already liked this post"
    else
      update_likes_counter

    end

    
    
  end
  

  def destroy
    
    @like=current_user.likes.find(params[:id])
    @post = @like.post
    puts @post.id
    @like.destroy
    update_likes_delete_counter
    # redirect_to @like.post
  end

  def like_params
    params.require(:like).permit(:post_id)
    
  end
  private

  def update_likes_counter
    puts "started"
    render turbo_stream:
      turbo_stream.replace("likes_#{@post.id}",
        partial: "likes/like",
        locals: { post: @post}
      
      
      )
  
  end

  def update_likes_delete_counter
    render turbo_stream:
      turbo_stream.replace("likes_#{@post.id}",
        partial: "likes/like",
        locals: { post: @post}
      
      
      )
  
  end

  

  
end
