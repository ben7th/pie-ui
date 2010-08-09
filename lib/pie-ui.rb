module PieUi
  class << self
    def enable_actionpack
      require 'pie-ui/convention'
      require 'pie-ui/mplist_helpers'
      ActionView::Base.send :include, MplistHelpers
    end
  end
end

if defined? Rails
  PieUi.enable_actionpack if defined? ActionController
end