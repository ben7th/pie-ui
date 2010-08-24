module PieUi
  module LogoHelper
    def guest_logo
      "<img alt='guest' class='logo guest' src='/images/logo/default_unknown_tiny.png'/>"
    end

    def logo(model, style=nil, id=nil)
      style_str = style.nil? ? '':"_#{style}"
      unless model.blank?
        "<img alt='#{get_visable_name(model)}' class='logo #{style}' id='logo_#{dom_id(model)}#{style_str}' src='#{model.logo.url(style)}'/>"
      else
        "<img alt='#{get_visable_name(model)}' class='logo #{style}' src='/images/logo/default_unknown_#{style}.png'/>"
      end
    end

    def get_visable_name(model)
      return t("NULLDATA") if model.blank?
      begin
        model.name
      rescue NoMethodError
        model.title
      end
    end

  end
end