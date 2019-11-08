module ApplicationHelper

  def full_title(page_name = "")
    base_title = "Sample"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
  
  def simple_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end 
  
  require "uri"
 
  def text_url_to_link(text)
 
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      text.gsub!(url, "<a href=\"#{url}\"target=\"_blank\">#{url}</a>")
    end
    text
  end
  
end