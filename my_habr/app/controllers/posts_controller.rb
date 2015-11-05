class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    set_post
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @comment = Comment.new
      if @post.save
        redirect_to @post, notice: 'Пост успешно создан.'
      else
        render :new
      end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

      if @post.update(post_params)
        redirect_to @post, notice: 'Пост успешно обновлен.'
      else
        render :edit
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
      redirect_to posts_url, notice: 'Пост успешно удален.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:id, :title, :body, category_ids: [])
    end
end