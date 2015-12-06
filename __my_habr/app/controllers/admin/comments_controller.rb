class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]


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
      redirect_to [:admin, @post], notice: 'Комментарий успешно создан.'
    else
      render :'new'
    end

  end


  def update
    @comment.user = current_user
    if @comment.update(comment_params)
      redirect_to [:admin, @comment], notice: 'Комментарий успешно обновлен.'
    else
      render :edit
    end
  end


  def destroy
    @comment.destroy
    redirect_to [:admin, @comment.post], notice: 'Комментарий успешно удален.'
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

end
