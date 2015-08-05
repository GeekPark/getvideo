module Getvideo

  # 有时候api返回的数据是无效的
  # http://vv.video.qq.com/geturl?vid=i0017eh61iu&otype=xml&platform=1&ran=0.9652906153351068
  # 原因未知
  # mp4 url的获取还是有难度的

  class QQ < Video

    set_api_uri do
      "http://vv.video.qq.com/geturl?vid=#{id}&otype=xml&platform=1&ran=#{rand}"
      # "http://vv.video.qq.com/getinfo?vid=#{id}"
    end


    def id
      vid = Rack::Utils.parse_query(URI(url).query)['vid']
      unless vid
        vid = cover.split("/").last.split("_").first
      end
      vid
    end

    def html_url
      url
    end

    def media
      begin
        response['root'] || {}
      rescue Exception =>e 
        {}
      end
    end

    def flash
      "http://imgcache.qq.com/tencentvideo_v1/player/TencentPlayer.swf?vid=#{id}"
    end

    def cover
      dom.css("meta[itemprop='image']").attr('content').to_s
    end

    def title
      dom.css('title').text().split(" - ").first
    end

    def play_media
      begin
        media['vd']['vi']['urlbk']['ui'][0]['url']
      rescue Exception =>e 
      end
    end

    protected
      def dom
        @dom ||= Nokogiri::HTML.fragment Faraday.get(url).body
      end

  end
end
