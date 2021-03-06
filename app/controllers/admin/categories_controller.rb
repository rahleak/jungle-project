class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD'], except: [:index]
  def index
    @categories = Category.order(:name).all
    puts @categories.name.to_yaml
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private 

  def category_params
    params.require(:category).permit(
      :name,
      :created_at,
      :updated_at
    )
  end

end