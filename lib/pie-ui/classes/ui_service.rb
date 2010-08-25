class UiService

  class << self

    def site
      CoreService.project('ui').url
    end

    def css_files
      ['common','ui'].map{|x| css_path(x)}
    end

    def css_path(bundle_name)
      pin_url_for 'ui',"stylesheets/bundle_#{bundle_name}.css?#{randstr}"
    end

    def theme_css_file
      pin_url_for 'ui',"stylesheets/themes/black.css?#{randstr}"
    end
  end

  class << self
    def js_lib_files
      [
        pin_url_for('ui',"javascripts/dev/prototype/protoaculous.1.8.3.min.js?#{randstr}"),
        pin_url_for('ui',"javascripts/dev/jquery/jquery-1.4.2.min.noconflict.js?#{randstr}")
      ]
    end

    def js_files
      ['common','mindpin'].map{|x| js_path(x)}
    end

    def js_path(bundle_name)
      pin_url_for 'ui',"javascripts/bundle_#{bundle_name}.js?#{randstr}"
    end
  end

end
