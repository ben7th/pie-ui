module PieUi
  module MplistHelper
    include PieUi::Convention

    def mplist(collection=[],options={},&block)
      
      config = PieUi::MplistHelperConfig.new(options)
  
      concat("<ul id='#{config.html_dom_id}' class='#{config.classname}' data-selectable='#{config.selectable}'>")
      block_given? ? _mplist_block_given(collection,&block) : _mplist_no_block(collection,config)
      concat("</ul>")
    end

    def _mplist_block_given(collection,&block)
      collection.each do |member|
        capture_str = capture(member, &block)
        case member
          when ActiveRecord::Base, MplistRecord
            _active_record_li(member,capture_str)
          else
            raise '传入 mplist 构建器的对象不是 ActiveRecord::Base 或 MplistRecord'
        end
      end
    end

    def _mplist_no_block(collection,config)
      collection.each do |member|
        if member.nil?
          concat '<li class="nilitem">nil item error</li>'
          next
        end

        capture_str = (render config.partial_configs_of(member))
        _active_record_li(member,capture_str)
      end
    end
    
    def _active_record_li(member,capture_str)
      concat(content_tag_for(:li, member, :class=>li_classname) {
        _fix_capture_tail_format(capture_str)
      })
    end

    # 去掉末尾的 \n 的目的是为了输出代码的整齐
    def _fix_capture_tail_format(capture_str)
      capture_str.sub(/\n$/,'') 
    end

    def li_classname
      'mpli'
    end

  end

  class MplistHelperConfig
    include PieUi::Convention
    include PieUi::MplistPartialMethods

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

    def partial_locals
      @partial_locals ||= (options[:locals] || {})
    end

    def partial_locals_of(model)
      {get_sym_of(model)=>model}.merge(partial_locals)
    end

    def partial
      @partial ||= options[:partial]
    end

    def partial_of(model)
      partial || get_partial_name_of_model(model)
    end

    def partial_configs_of(model)
      {:partial=>partial_of(model),:locals=>partial_locals_of(model)}
    end
  end
end