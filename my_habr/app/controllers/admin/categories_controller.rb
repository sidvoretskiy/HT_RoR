class Admin::CategoriesController < Admin::BaseController
before_action :set_category, only: [:show, :edit, :update, :destroy]


  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to '/admin/categories/', notice: 'Категория успешно создана.'
    else
      render admin_categories_path
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Категория удалена.'
  end

  def update
    if @category.update(category_params)
      redirect_to '/admin/categories/', notice: 'Категория успешно обновлена.'
    else
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :id)
  end

end