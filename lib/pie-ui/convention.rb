module PieUi

  module Convention
    include ActionController::RecordIdentifier

    # plural_class_name 是 ActionController::RecordIdentifier 中的方法
    # 根据传入的对象或对象数组，获取目标对象名的可读字符串，用于mplist的classname
    def get_mplist_for_object_classname(object_or_objects)
      case object_or_objects
      when nil
        'unknown'
      else
        plural_class_name [object_or_objects].flatten(1).last
      end
    end

    # 根据传入的类或数组获取 页面列表对象的 dom id
    #   传入： Cooking::ApplePie
    #     返回 'cooking_apple_pies'
    #   
    #   传入: [<Book id=23>,Cooking::ApplePie]
    #     返回 book_23_cooking_apple_pies
    #
    #   传入: [:my,<Book id=23>,Cooking::ApplePie]
    #     返回 my_book_23_cooking_apple_pies
    #   
    # 如果是数组，组装每个部分并用 _ 连接
    def build_ul_id(ul_for)
      case ul_for
        when Class
          # Apple
          build_ul_id_part(ul_for)
        when Array
          # [<Apple id:33>, Foo::Bar]
          ul_for.map{|x| build_ul_id_part(x)}*'_'
      end
    end

    # 根据传入的对象或者数组来构建一个用于集合的html_id
    # 此函数用于构建每个部分
    def build_ul_id_part(ul_for_part)
      case ul_for_part
        when Class
          ul_for_part.name.underscore.pluralize.gsub('/','_')
        when ActiveRecord::Base
          dom_id(ul_for_part)
        when String, Symbol
          ul_for_part
      end
    end

    # 产生随机字符串
    def randstr(length=8)
      base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      size = base.size
      re = ''<<base[rand(size-10)]
      (length-1).times  do
        re<<base[rand(size)]
      end
      re
    end
    
  end

  module MplistPartialMethods
    # 根据 ActiveRecord 模型 获取对应的模板基准名
    def get_partial_base_name_of_model(model)
      underscore_class_name_of(model).demodulize
    end

    # 根据 ActiveRecord 模型 获取带有目录信息的模板名
    def get_partial_name_of_model(model)
      get_partial_name_of_model_with_prefix(:mpinfo,model)
    end

    def get_partial_name_of_model_with_prefix(prefix,model)
      "#{underscore_class_name_of(model).pluralize}/parts/#{prefix}_#{get_partial_base_name_of_model(model)}"
    end

    def underscore_class_name_of(model)
      model.class.name.underscore
    end

    def get_sym_of(model)
      get_partial_base_name_of_model(model).to_sym
    end
  end
  
end