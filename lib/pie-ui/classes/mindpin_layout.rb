class MindpinLayout
  attr_accessor :theme
  attr_accessor :grid
  attr_accessor :yield_partial
  attr_accessor :hide_nav, :hide_footer
  attr_accessor :head_class
  attr_accessor :put_js_in_head

  module ControllerFilter
    def self.included(base)   
      base.before_filter :init_layout
      base.before_filter :enable_base_layout

      base.send(:include,InstanceMethods)
    end

    module InstanceMethods
      def init_layout
        @mindpin_layout = MindpinLayout.new
      end

      def enable_base_layout
        render :layout=>base_layout_path('application.haml')
      end
    end
  end

end
