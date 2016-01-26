#coding:utf-8

module Getvideo
  class Youku < Video
    set_api_uri { "http://v.youku.com/player/getPlayList/VideoIDS/" + id }

    def id
      if url =~ /\.html/
        url.scan(/id_([^.]+)/)[0][0]
      elsif url =~ /\.swf/
        url.scan(/sid\/([^\/]+)\/v.swf/)[0][0]
      end
    end

    def videoid
      info['data']['id']
    end

    def html_url
      "http://v.youku.com/v_show/id_#{id}.html"
    end

    def title
      info['data']['video']['title']
    end

    def cover
      info['data']['video']['logo']
    end

    def flash
      "http://player.youku.com/player.php/sid/#{id}/v.swf"
    end

    def iframe
      "http://player.youku.com/embed/#{id}"
    end

    def m3u8
      cmd = "node #{Getvideo.root.join("js","youku_get_m3u8.js")} #{id}"
      `#{cmd}`.strip
    end

    def media(type = nil)
      {
        'mp4' => [m3u8],
        'flash' => [flash],
        'iframe' => [iframe],
      }
    end

    private

    def info
      @info ||= begin
        url = "http://play.youku.com/play/get.json?vid=" + id + "&ct=12"
        result = Faraday.get url,{},referer: 'http://www.youku.com'
        hash = JSON.parse(result.body)
      end
    end
  end
end
