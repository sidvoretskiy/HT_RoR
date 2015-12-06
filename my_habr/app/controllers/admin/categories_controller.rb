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
      redirect_to '/admin/categories/', notice: t('admin.categories.notices.create')
    else
      render :new #, notice: @category.errors[0]
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: t('admin.categories.notices.delete')
  end

  def update
    if @category.update(category_params)
      redirect_to '/admin/categories/', notice: t('admin.categories.notices.update')
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