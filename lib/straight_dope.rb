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
  
  class ImglyAdapter
    def self.match?(url)
      !(url =~ /img\.ly/).nil?
    end
    
    def self.extract(url)
      uri = URI.parse(url)
      id = uri.path
      "http://img.ly/show/full#{uri.path}"
    end
  end
  
  class PlixiAdapter
    def self.match?(url)
      !(url =~ /plixi\.com/).nil?
    end
    
    def self.extract(url)
      uri = URI.parse(url)
      "http://api.plixi.com/api/tpapi.svc/imagefromurl?size=large&url=#{url}"
    end
  end
  
  class MobyAdapter
    def self.match?(url)
      !(url =~ /moby\.to/).nil?
    end
    
    def self.extract(url)
      uri = URI.parse(url)
      id = uri.path
      "http://moby.to/#{id}:full"
    end
  end
  
  def self.extract_media(content)
    urls = URI.extract content
    media_urls = []

    urls.each do |u|
      url = process_redirects(u)
      adapters = [YfrogAdapter, TwitPicAdapter, TwitGooAdapter, ImglyAdapter, PlixiAdapter, MobyAdapter]
      adapters.each do |adapter|
        if adapter.match? url
          media_urls << adapter.extract(url)
          break
        end
      end
    end
    
    media_urls
  end

  def self.process_redirects(u)
    response = Net::HTTP.get_response(URI.parse(u))
    return u unless response.kind_of?(Net::HTTPRedirection)

    limit = 3

      while limit > 0 && response.kind_of?(Net::HTTPRedirection)

        u = response['location']
        response = Net::HTTP.get_response(URI.parse(u))

        limit -= 1
      end
    u
  end
  
end