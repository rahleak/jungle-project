class Admin::DashboardController < ApplicationController
  def show
    @amount_of_products = Product.count()
    @amount_of_catergories = Category.count()
  end
end
