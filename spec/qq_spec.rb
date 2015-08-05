require 'spec_helper'
require "rack"

describe Getvideo::QQ do
  let(:qq){ Getvideo::QQ.new("http://v.qq.com/cover/4/4adth2878l67nb7.html?vid=l0017egzl2z") }

  describe "#title" do
    it{ qq.title.should == "网罗天下 宅男福音：日本“美女机器人”亮相 爱看电影动漫" }
  end

  describe "#cover" do
    it{ qq.cover.should == "http://vpic.video.qq.com/93819629/v0017sfax4i_160_90_3.jpg" }
  end

  describe "#flash" do
    it{ qq.flash.should == "http://imgcache.qq.com/tencentvideo_v1/player/TencentPlayer.swf?vid=l0017egzl2z" }
  end

  describe "#play_media" do
  end

end
