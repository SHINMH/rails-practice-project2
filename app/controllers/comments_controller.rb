class CommentsController < ApplicationController
  def create
    @comment = Comment.create comment_params
    @item = Item.find_by(id: @comment.item_id)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    
    @item = Item.find_by(id: @comment.item_id)
  end

  private 
  def comment_params
    params.require(:comment).permit(:content, :user_id, :item_id)
  end
end