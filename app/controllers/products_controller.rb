class ProductsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :identify_product

  def index
    @products = Product.all
  end

  def show
    send_file @path, :disposition => "attachment; filename=#{@file}"
  end

  def new
    @product = Product.new
  end

  def create
    if @product = Product.new(product_params).save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to(categories_path)
  end

  private

  def identify_product
    valid_characters = "^[0-9a-zA-Z]*$".freeze
    unless params[:id].blank?
      @product_id = params[:id]
      @product_id = @product_id.tr("^#{valid_characters}", '')
    else
      raise "Filename missing"
    end
    unless params[:format].blank?
      @format = params[:format]
      @format = @format.tr("^#{valid_characters}", '')
    else
      raise "File extension missing"
    end
    @path = "app/views/products/#{@product_id}.#{@format}"
    @file = "#{@product_id}.#{@format}"
  end

  def product_params
    params.require(:product).permit(:name, :coating, :price, :description, :other)
  end

end

