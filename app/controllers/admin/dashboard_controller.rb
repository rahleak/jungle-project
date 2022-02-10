class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASSWORD'], except: [:index]
  def show
    @amount_of_products = Product.count()
    @amount_of_catergories = Category.count()
  end
end
