#coding:utf-8
require 'spec_helper'

describe Getvideo::Iqiyi do
  let(:iqiyi){ Getvideo::Iqiyi.new("http://www.iqiyi.com/weidianying/20120925/f15221a897037d07.html")}
  let(:iqiyi2){ Getvideo::Iqiyi.new "http://www.iqiyi.com/v_19rrh4jv9s.html" }
  let(:iqiyi3){ GetVideo::Iqiyi.new "http://www.iqiyi.com/v_19rro02q0w.html#vfrm=3-2-bee-1" }

  let(:iqiyi_swf){ Getvideo::Iqiyi.new("http://player.video.qiyi.com/38c130b7b4124b1e902161e8e377324b/0/649/weidianying/20120925/f15221a897037d07.swf-pid=47084-ptype=2-albumId=233012-tvId=280286")}

  let(:iqiyi_id){ Getvideo::Iqiyi.new("38c130b7b4124b1e902161e8e377324b")}

  describe "#id" do
    it "should return id" do
      iqiyi.id.should == "38c130b7b4124b1e902161e8e377324b"
      iqiyi2.id.should == "8e0f5866b1d89f9328551ab98a95f102"
      iqiyi_swf.id.should == "38c130b7b4124b1e902161e8e377324b"
      iqiyi_id.id.should == "38c130b7b4124b1e902161e8e377324b"
    end
  end

  describe "#url" do
    it{
      iqiyi.html_url.should eq("http://www.iqiyi.com/weidianying/20120925/f15221a897037d07.html")
    }
  end

  describe "#title" do
    it { 
      iqiyi.title.should match(/网络/)
    }
  end

  describe "#m3u8" do
    it { 
      iqiyi.m3u8.should == "http://metan.video.qiyi.com/161/2d67f7aa72fe95ee65d36ca7ceabb69e.m3u8" 
    }
  end

  describe "#flash" do
    it{ iqiyi.flash.should == "http://player.video.qiyi.com/38c130b7b4124b1e902161e8e377324b/0/649/weidianying/20120925/f15221a897037d07.swf" }
  end

  describe "#media" do
    it{ iqiyi.media["f4v"].count.should eq(2) }
  end

  describe "#cover" do
    it{ iqiyi.cover.should =~ /qiyipic\.com/ }
  end
end
