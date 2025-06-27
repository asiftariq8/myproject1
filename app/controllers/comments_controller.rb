class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def create
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: "Comment added." }
        format.js   # renders create.js.erb
      else
        format.html { redirect_to @product, alert: "Failed to comment." }
        format.js   # renders create.js.erb with errors (optional)
      end
    end
  end

  def edit
    # renders edit.js.erb
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @product, notice: 'Comment updated.' }
        format.js   # renders update.js.erb
      else
        format.html { redirect_to @product, alert: 'Update failed.' }
        format.js   # optional: render form with errors
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Comment deleted.' }
      format.js   # renders destroy.js.erb
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
    unless @comment.user == current_user
      respond_to do |format|
        format.html { redirect_to @product, alert: "Not authorized." }
        format.js { render js: "alert('Not authorized');" }
      end
    end
  end
end
