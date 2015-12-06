class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authority_check, only: [:edit, :update, :destroy]


  def index
    @comments = Comment.all
  end


  def show
  end


  def new
    @comment = Comment.new
  end


  def edit
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: t('comments.notices.create')
    else
      render :'new'
    end

  end

  def update
    @comment.user = current_user
    if @comment.update(comment_params)
      redirect_to @comment, notice: t('comments.notices.update')
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: t('comments.notices.delete')
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :post_id, :id, :user_id)
  end

  def authority_check
    unless @comment.user == current_user || current_user.admin?
      redirect_to post_path, notice: t('comments.notices.no_authority')
    end
  end


end
