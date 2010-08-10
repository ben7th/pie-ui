module PieUi
  class << self
    def enable_actionpack
      require 'pie-ui/convention'
      require 'pie-ui/mplist_helper'
      require 'pie-ui/xml_format_helper'
      ActionView::Base.send :include, MplistHelper
      ActionView::Base.send :include, XmlFormatHelper
    end
  end
end

if defined? Rails
  PieUi.enable_actionpack if defined? ActionController
end