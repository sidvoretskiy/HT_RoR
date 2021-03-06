class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)


      if @category.save
        redirect_to '/categories/', notice: 'Категория успешно создана.'
      else
        render :new
      end

  end

  def show
    set_category
    @posts = @category.posts
  end

  def edit
    @category = Category.find(params[:id])
  end

  def destroy
    set_category
    @category.destroy
    redirect_to categories_url, notice: 'Категория удалена.'
  end

  def update
    set_category
    if @category.update(category_params)
      redirect_to '/categories/', notice: 'Категория успешно обновлена.'
    else
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_ids)
  end



end
