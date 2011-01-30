class PublicController < ApplicationController
  
  respond_to :html
  respond_to :atom, :rss, :only => :syndicate
  
  def index
    images = Image.order('date DESC').limit(7).all
    @img = images.first
    @links = images.reverse
  end
  
  def view
    date = params[:y] + "-" + params[:m] + "-" + params[:d]
    @img = Image.where(:date => date).first
    if @img.nil?
      redirect_to '/'
      return false
    end
    @show_prevNext = true
    @pgtitle = @img.caption + " - " + @img.date.strftime("%B %d, %Y")
  end
  
  def photo  
    date = params[:y] + "-" + params[:m] + "-" + params[:d]
    @img = Image.where(:date => date).first
    if @img.nil?
      redirect_to '/'
      return false
    end
    redirect_to @img.full_path_url
  end
  
  def small_photo  
    date = params[:y] + "-" + params[:m] + "-" + params[:d]
    @img = Image.where(:date => date).first
    if @img.nil?
      redirect_to '/'
      return false
    end
    redirect_to @img.thumbnail_url
  end
  
  def about
    @pgtitle = "About"
  end
  
  def syndicate
    @pgtitle = "Syndication"
    respond_with(@images = Image.order('date DESC').limit(10))
  end
  
  def archive
    @start_year = Image.first.date.year
    @end_year = Image.last.date.year
    @pgtitle = "Archive"
  end
  
  def month
    redirect_to "/#{ params[:y] }#month-#{ params[:m] && params[:m].to_i }"
  end
  
  def year
    year = params[:y]
    if Rails.env.production?
      @imgs = Image.where('date > ? and date < ?', "#{year.to_i - 1}-12-31", "#{year.to_i + 1}-01-01").order('date ASC').all
    else
      @imgs = Image.where('date like ?', "#{year}-%").order('date ASC').all
    end
    raise ActiveRecord::RecordNotFound if @imgs.empty?
    @pgtitle = @imgs.first.date.strftime("%Y") + " Archives"
  end   
  
end