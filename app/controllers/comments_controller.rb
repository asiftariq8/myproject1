class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def create
    return head :forbidden if @product.user == current_user

    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @product, notice: 'Comment posted.' }
      end
    else
    end
  end

  def edit 
     
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @product, notice: 'Comment updated.' }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @product, notice: 'Comment deleted.' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :image)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    @comment = @product.comments.find(params[:id])
  end

  def authorize_user!
    redirect_to @product, alert: "Not authorized" unless @comment.user == current_user
  end
end
