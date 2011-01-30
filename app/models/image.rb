class Image < ActiveRecord::Base
  
  before_validation :fetch_flickr_details
  
  def self.from_decade(decade_image)
    i = Image.new(decade_image)
    i.full_path_url = i.date.strftime("http://cdn.m.ac.nz/decade/images/%Y%m%d.jpg")
    i.thumbnail_url = i.date.strftime("http://cdn.m.ac.nz/decade/images/small/%Y%m%d.jpg")
    i.save
  end
  
  def fetch_flickr_details
    if photo_id?
      update_flickr_info(photo_id)
    end
  end
  
  def permalink (full = false)
    r = self.date.strftime("/%Y/%m/%d/")
    r = DC_CONFIG[:BASE].gsub(/\/$/, "") + r if full
    r
  end


  def prev
    self.class.where('date < ?', self.date).order('date DESC').first
  end
  def next
    self.class.where('date > ?', self.date).order('date ASC').first
  end
  
  private
  
  class FlickrAPI
    include HTTParty
    base_uri 'www.flickr.com'
    format :json
    
    def self.photoInfo(photo_id, options = {})
      options.merge! :photo_id => photo_id, :method => 'flickr.photos.getInfo', :format => 'json', :api_key => ENV['FLICKR_KEY'], :nojsoncallback => 1
      res = get '/services/rest/', :query => options
      res['stat'] == "ok" && res['photo']
    end
    
  end
  
  def gen_flickr_url(photo, size)
    "http://farm#{ photo['farm'] }.static.flickr.com/#{ photo['server']}/#{ photo['id'] }_#{ photo['secret'] }#{ size && ("_" + size) }.jpg"
  end
  
  def update_flickr_info(photo_id)
    f = FlickrAPI.photoInfo(photo_id)
    self.flickr_url = f['urls']['url'][0]['_content']
    self.full_path_url = gen_flickr_url(f, 'b')
    self.thumbnail_url = gen_flickr_url(f, 's')
    
    self.caption = f['title']['_content'] if self.caption.blank?
    self.description = f['description'] if self.caption.blank?
    
    logger.info "FFS" + self.to_yaml
  end
end
