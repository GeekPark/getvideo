#coding:utf-8
require 'spec_helper'

describe Getvideo::Youku do
  let(:youku){ Getvideo::Youku.new("http://v.youku.com/v_show/id_XNDQ2MzE4MzMy.html") }
  let(:youku_vip){ Getvideo::Youku.new "http://v.youku.com/v_show/id_XNDYzOTQ1OTky.html" }
  let(:youku_swf){ Getvideo::Youku.new "http://player.youku.com/player.php/sid/XNDQ2MzE4MzMy/v.swf"}
  let(:youku_id){ Getvideo::Youku.new "XNDQ2MzE4MzMy"}

  describe "#html_url" do
    it{ youku.html_url.should == "http://v.youku.com/v_show/id_XNDQ2MzE4MzMy.html" }
    it{ youku_vip.html_url.should == "http://v.youku.com/v_show/id_XNDYzOTQ1OTky.html" }
  end

  describe "#title" do
    it{ youku.title.should match(/1/)}
    it{ youku_vip.title.should match(/青楼/)}
  end

  describe "#id" do
    context "when is html url" do
      it{ youku.id.should == "XNDQ2MzE4MzMy" }
    end

    context "when is swf url" do
      it{ youku_swf.id.should == "XNDQ2MzE4MzMy" }
    end
  end

  describe "#cover" do
    it{ youku.cover.should =~ /ykimg\.com/ }
  end

  describe "#flash" do
    it { youku.flash.should ==  "http://player.youku.com/player.php/sid/XNDQ2MzE4MzMy/v.swf" }
  end

  describe "#media" do
    let(:youku){ Getvideo::Youku.new "http://v.youku.com/v_show/id_XNDYwNjU1NDky.html" }
    it{ youku.media.count.should equal(3) }
    it{ youku_vip.media.count.should equal(3) }
  end

  describe "#m3u8" do
    # http://pl.youku.com/playlist/m3u8?vid=352444802&type=mp4&ts=1451051209&keyframe=0&ep=cCaRG0mIV8wA7CHfgT8bMS60dyNaXP0P9BuBhdpiAtQmSum7&sid=245105120920912f2f3de&token=2214&ctype=12&ev=1&oip=827005847
    it{
      youku.m3u8.should == "http://v.youku.com/player/getM3U8/vid/111579583/type/flv/ts/v.m3u8"
    }
  end
end
