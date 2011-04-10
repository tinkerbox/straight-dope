require 'net/http'

module StraightDope
  
  class YfrogAdapter
    def self.match?(url)
      !(url =~ /yfrog\.com/).nil?
    end
    
    def self.extract(url)
      uri = URI.parse(url)
      id = uri.path
      "http://yfrog.com#{uri.path}:medium"
    end
  end
  
  class TwitPicAdapter
    def self.match?(url)
      !(url =~ /twitpic\.com/).nil?
    end
    
    def self.extract(url)
      uri = URI.parse(url)
      id = uri.path
      "http://twitpic.com/show/full#{uri.path}"
    end
  end
  
  class TwitGooAdapter
    def self.match?(url)
      !(url =~ /twitgoo\.com/).nil?
    end
    
    def self.extract(url)
      uri = URI.parse(url)
      id = uri.path
      "http://twitgoo.com/show/img#{uri.path}"
    end
  end
  
  def self.extract_media(content)
    urls = URI.extract content
    media_urls = []
    
    urls.each do |u|
      response = Net::HTTP.get_response(URI.parse(u))
      u = response['location']
      
      limit = 3
      
      while limit > 0 && response.kind_of?(Net::HTTPRedirection)
        response = Net::HTTP.get_response(URI.parse(u))
        u = response['location']
        limit -= 1
      end
      
      adapters = [YfrogAdapter, TwitPicAdapter]
      adapters.each do |adapter|
        if adapter.match? u
          media_urls << adapter.extract(u)
          break
        end
      end
    end
    
    media_urls
  end
  
end