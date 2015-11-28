class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to '/admin/posts/', notice: 'Пост успешно создан.'
    else
      render admin_posts_path
    end
  end

  def show
    set_post
    @comment = Comment.new
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Пост удален.'
  end

  def update
    if @post.update(post_params)
      redirect_to '/admin/posts/', notice: 'Пост успешно обновлен.'
    else
      render :edit
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :id)
  end

end