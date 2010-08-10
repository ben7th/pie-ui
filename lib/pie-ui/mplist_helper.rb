module PieUi
  module MplistHelper
    def mplist(collection=[],options={},&block)
      
      config = PieUi::MplistConfig.new(options)
  
      concat("<ul id='#{config.html_dom_id}' class='#{config.classname}' data-selectable='#{config.selectable}'>")
      block_given? ? _mplist_block_given(collection,&block) : _mplist_no_block(collection,config)
      concat("</ul>")
    end

    def _mplist_block_given(collection,&block)
      collection.each do |member|
        capture = capture(member, &block).sub(/\n$/,'') # 去掉末尾的 \n 的目的是为了输出代码的整齐
        case member
          when ActiveRecord::Base
            _active_record_li(member,capture)
          else
            _common_object_li(member,capture)
        end
      end
    end
    
    def _active_record_li(member,capture)
      concat(content_tag_for(:li, member, :class=>li_classname) {
        capture
      })
    end

    def _common_object_li(member,capture)
      concat("<li id='#{_build_object_html_id member}' class='#{li_classname}'>")
      concat(capture)
      concat("</li>")
    end

    def li_classname
      'mpli'
    end

    def _build_object_html_id(obj)
      "#{obj.class.name}_o#{obj.object_id}"
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
      @classname ||= ['mplist',options[:class],object_classname].compact*' '
    end

    def html_dom_id
      @html_dom_id ||= "mplist_#{options[:id] || build_ul_id(options[:for]) || randstr}"
    end
  end
end