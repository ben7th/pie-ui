module PieUi
  module MplistHelpers
    def mplist(collection=[],options={},&block)
      
      config = PieUi::MplistConfig.new(options)
  
      concat("<ul id='#{config.html_dom_id}' class='#{config.classname}' data-selectable='#{config.selectable}'>")
      concat("</ul>")
    end
  end

  class MplistConfig
    include PieUi::Convention

    attr_reader :options

    def initialize(options={})
      @options = options
    end

    def object_classname
      @for_classname ||= get_mplist_for_object_classname(options[:for])
    end

    def selectable
      @selectable ||= !!options[:selectable]
    end

    def classname
      @classname ||= ['mplist',options[:class],object_classname]*' '
    end

    def html_dom_id
      @html_dom_id ||= "mplist_#{options[:id] || build_ul_id(options[:for]) || rand}"
    end
  end
end