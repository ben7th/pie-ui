module PieUi
  module MplistModule
    include PieUi::MplistPartialMethods

    # mplist综合渲染器
    # 使用方法：
    #   ui.mplist(:操作, 选择器, 其他参数)
    #
    # 根据 模型 和默认规则指定 ul li model
    #   ui.mplist(:操作, <ActiveRecord::Base>)
    #   ui.mplist(:操作, <ActiveRecord::Base>, {:partial=>xxx,:locals=>{:xxx=>xxx}})
    #
    # 根据 包括模型的数组 和默认规则指定 ul li model， 而且给模板传入额外参数
    #   ui.mplist(:操作, [:prefix,<ActiveRecord::Base>])
    #   ui.mplist(:操作, [:prefix,<ActiveRecord::Base>], {:partial=>xxx,:locals=>{:xxx=>xxx}})
    #
    # 自己指定 ul li model
    #   ui.mplist(:操作, {:ul=>xxx, :li=>xxx, :model=>xxx}
    #   ui.mplist(:操作, {:ul=>xxx, :li=>xxx, :model=>xxx}, {:partial=>xxx,:locals=>{:xxx=>xxx}})
    #
    # 如果不指定 partial 将根据 model 指定 partial
    def mplist(operation, selector, extra={}, &block)
      if [:insert,:update,:new,:edit,:remove,:javascript].include?(operation)
        page << eval("_build_#{operation}_mplist_js(selector,extra,&block)")
      end
      return self
    end

    def _build_insert_mplist_js(selector,extra)
      model = _get_model(selector)
      ul_pattern = _get_ul_pattern(selector)

      prev_li_pattern = _get_li_pattern(extra[:prev])
      str = context.content_tag_for :li,model,:class=>'mli' do
        _get_partial_str(:info,model,extra)
      end

      %`
        $$(#{ul_pattern.to_json}).each(function(ul){
          pie.mplist.insert_li(ul,#{str.to_json},#{prev_li_pattern.to_json});
        });
      `
    end

    def _build_remove_mplist_js(selector,extra)
      li_pattern = _get_li_pattern(selector)
      %`
        $$(#{li_pattern.to_json}).each(function(li){
          pie.mplist.remove_li(li);
        });
      `
    end

    def _build_update_mplist_js(selector,extra)
      model = _get_model(selector)
      li_pattern = _get_li_pattern(selector)
      str = _get_partial_str(:info,model,extra)
      %`
        $$(#{li_pattern.to_json}).each(function(li){
          pie.mplist.update_li(li,#{str.to_json});
        });
      `
    end

    def _build_new_mplist_js(selector,extra)
      model = _get_model(selector)
      ul_pattern = _get_ul_pattern(selector)

      prev_model = extra[:prev]
      prev_model_html_id = prev_model.nil? ? nil : (dom_id prev_model)

      str = context.content_tag_for :li,model,:class=>'mli' do
        _get_partial_str(:form,model,extra)
      end

      %`
        $$(#{ul_pattern.to_json}).each(function(ul){
          pie.mplist.open_new_form(#{str.to_json},ul,#{prev_model_html_id.to_json});
        });
      `
    end

    def _get_ul_pattern(selector)
      case selector
        when ActiveRecord::Base
          "#mplist_#{build_ul_id selector}"
        when Array
          "#mplist_#{build_ul_id selector}"
        when Hash
          selector[:ul]
      end
    end

    def _get_li_pattern(selector)
      case selector
        when ActiveRecord::Base
          "##{dom_id selector}"
        when Array
          "##{dom_id selector.last}"
        when Hash
          selector[:li]
        else
          selector
      end
    end

    def _get_model(selector)
      case selector
        when ActiveRecord::Base
          selector
        when Array
          selector.last
        when Hash
          selector[:model]
      end
    end

    def _get_partial_str(prefix,extra)
      
      _render_partial(extra)
    end
    
  end
end
