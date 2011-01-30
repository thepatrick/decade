class ImagesController < ApplicationController
  
  before_filter :require_user
  
  # layout 'admin'
  
  def index
    redirect_to root_path    
  end
  
  def new
    @pgtitle = "New image"
    @image = Image.new
    @image.date = Time.now
  end
  
  def create
    @image = Image.new params[:image]
    if @image.save
      redirect_to @image.permalink
    else
      render :action => :new
    end
  end
  
  def show
    redirect_to edit_image_path(params[:id])
  end
  
  def edit
    @pgtitle = "Edit image"
    @img = @image = Image.find(params[:id])
  end
  
  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      redirect_to @image.permalink
    else
      render :action => :edit
    end
  end
  
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to images_path
  end
  
end
