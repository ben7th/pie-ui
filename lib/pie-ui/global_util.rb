module GlobalUtil
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
