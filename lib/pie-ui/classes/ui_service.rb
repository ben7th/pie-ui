class UiService

  class << self

    def site
      CoreService.project('ui').url
    end

    def css_files
      ['common','ui'].map{|x| css_path(x)}
    end

    def css_path(bundle_name)
      File.join site,"stylesheets/bundle_#{bundle_name}.css?#{randstr}"
    end

    def theme_css_file
      File.join site,"stylesheets/themes/black.css?#{randstr}"
    end
  end

  class << self
    def js_lib_files
      [
        File.join(site,"javascripts/dev/prototype/protoaculous.1.8.3.min.js?#{randstr}"),
        File.join(site,"javascripts/dev/jquery/jquery-1.4.2.min.noconflict.js?#{randstr}")
      ]
    end

    def js_files
      ['common','mindpin'].map{|x| js_path(x)}
    end

    def js_path(bundle_name)
      File.join site,"javascripts/bundle_#{bundle_name}.js?#{randstr}"
    end
  end

end
