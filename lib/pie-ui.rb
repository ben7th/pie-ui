module PieUi
  class << self
    def enable_actionpack
      require 'pie-ui/convention'

      require 'pie-ui/mplist_helper'
      ActionView::Base.send :include, MplistHelper

      require 'pie-ui/xml_format_helper'
      ActionView::Base.send :include, XmlFormatHelper

      require 'pie-ui/bundle_helper'
      ActionView::Base.send :include, BundleHelper
    end
  end
end

if defined? Rails
  PieUi.enable_actionpack if defined? ActionController
  def Rails.production?
    Rails.env == 'production'
  end
  def Rails.development?
    Rails.env == 'development'
  end
end