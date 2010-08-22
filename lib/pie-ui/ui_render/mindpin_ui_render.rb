module PieUi
  class MindpinUiRender
    def initialize(context,page,&block)
      @page = page # rjs 的调用句柄
      @context = context # controller上下文实例
      @controller = @context.instance_exec{@controller} # controller实例
    end

    attr_reader :page
    attr_reader :context
    attr_reader :controller

    def render(*args)
      context.render(*args)
    end

    def js(string)
      @page << string
      return self
    end

    private
      # 根据传入参数获得包含action和controller的hash
      # {:action=>"create", :controller=>"text_entries"}
      def recognize_path(url,options)
        ActionController::Routing::Routes.recognize_path(url,options)
      end

    module MindpinUiRender::CellModule
      def cell(*args)
        model = args.first
        options = args.extract_options!

        options[:locals] ||= {}
        options[:partial] ||= "#{get_path_of_controller}/cell_#{controller.action_name}"

        _render_page(model,options)
      end

      private
        def _render_page(model,options)
          locals = case model
            when Symbol
              options[:locals]
            when ActiveRecord::Base
              {get_sym_of(model)=>model}.merge(options[:locals])
            when Hash
              options[:locals]
            else
              options[:locals]
          end
          position = context.params[:PL] || options[:position]

          html_str = (render :partial=>options[:partial],:locals=>locals)
          page<<"pie.cell.update_html(#{position.to_json},#{html_str.to_json})"
        end
    end

    include PieUi::Convention
    include PieUi::FboxModule
    include PieUi::MplistModule
    include CellModule
  end

end