Paperclip.options[:image_magick_path] = APP_CONFIG['image_magick_path']
class Event < ActiveRecord::Base
  
  default_scope :order => "start_date asc"
  named_scope :displayable, :order => "start_date asc", :conditions => ["start_date > ?", Time.now - 3.hours]
  
  has_attached_file :image,
                    :styles => { :small => ["300x300>", :jpg], :large => ["700x525>", :jpg], :thumb => ["100x100#", :jpg] },
                    :default_style => :small,
                    :url => "/system/uploads/:class/:attachment/:id/:style/image.:extension",
                    :path => ":rails_root/public/system/uploads/:class/:attachment/:id/:style/image.:extension"
  
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  def permalink
    self.name.downcase.gsub(" ", "-").gsub(/[^a-z0-9-]+/, '')
  end
  
  def secret_code
    Digest::MD5.hexdigest("#{self.created_at}-#{self.id}-thinga")
  end
  
  def body
    self.description.blank? ? self.summary : self.description
  end
  
end
