class CommentsController < ApplicationController
  def index
    if params.has_key?(:commentable)
      @comment = Comment.where(commentable: params[:commentable_id])
    else
      @comment = Comment.all
    end
    render json: @comment
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    render json: @comment
  end


  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment
    else
        render(
          json: @comment.errors.full_messages, status: 422
        )
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])

    if @comment.destroy
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end


  private
  def comment_params
    params[:comment].permit(:body)
  end

end
