class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish,
                                  :unpublish, :subscribe, :unsubscribe, :approve,
                                  :reject, :send_notification]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authority_check, only: [:edit, :update, :destroy]
  after_action :send_notification, only: [:approve, :reject]


  def index
   @posts = Post.moderated.all
  end

  def unpublished
    @posts = Post.unpublished.owner(current_user).all
    render :index
  end

  def moderation
    @posts = Post.moderation.all
    render :index
  end

  def approve
    @post.moderated = true
    if @post.save
      redirect_to moderation_posts_path, notice: t('posts.notices.approved')
    else
      render :edit
    end
  end

  def reject
    @post.moderated = false
    @post.published = false
    if @post.save
      redirect_to moderation_posts_path, notice: t('posts.notices.rejected')
    else
      render :edit
    end
  end

  def send_notification
    NotificationMailer.moderation_notification(@post).deliver_now
  end

  def show
    set_post
    @comment = Comment.new
  end


  def new
    @post = Post.new
    # @post = current_user.posts.new(post_params)
    @post.user = User.find(2)
  end


  def edit
  end

  def publish
    @post.published = true
    if @post.save
      redirect_to unpublished_posts_path, notice: t('posts.notices.update')
    else
      render :edit
    end
  end

  def unpublish
    @post.published = false
    @post.moderated = false
    if @post.save
      redirect_to unpublished_posts_path, notice: t('posts.notices.update')
    else
      render :edit
    end
  end

  def create
    # @post = Post.new(post_params)
    # @comment = Comment.new
    @post = current_user.posts.new(post_params)

      if @post.save
        redirect_to @post, notice: t('posts.notices.create')
      else
        render :new
      end
  end


  def update
      if @post.update(post_params)
        redirect_to @post, notice: t('posts.notices.update')
      else
        render :edit
      end
  end


  def destroy
    @post.destroy
    redirect_to posts_url, notice: t('posts.notices.delete')
  end

  def unsubscribe
    @post.subscribers.delete(current_user)
    if @post.save
      redirect_to @post, notice: t('posts.notices.unsubscribe')
    else
      render @posts
    end
  end

  def subscribe
    @post.subscribers << current_user
    if @post.save
      redirect_to @post, notice: t('posts.notices.subscribe')
    else
      render @posts
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:id, :title, :body, :published, category_ids: [])
    end

    def creator_check
      if  @post.user != current_user
        redirect_to post_path, notice: t('posts.notices.no_authority')
      end
    end

  def authority_check
    unless  @post.user == current_user || current_user.admin == true
      redirect_to post_path, notice: t('posts.notices.no_authority')
    end
  end
end