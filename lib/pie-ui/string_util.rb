class String
  def url_to_site
    ip_match = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/
    host = URI.parse(self).host
    # IP 地址
    if ip_match.match(host)
      return host
    end
    # stackoverflow.com
    if host.split(".").length == 2
      return host
    end
    str_arr = host.split(".")
    str_arr.shift
    return str_arr*"."
  end

  # 根据url得到这个地址的domain
  def url_to_domain
    URI.parse(self).host
  end

  def add_url_param(k,v)
    hash = self.get_url_params_hash
    hash[k] = v
    if self.include?('?')
      tmp = self.split('?')[-2]
    else
      tmp = self
    end
    "#{tmp}?#{CGI.unescape hash.to_param}"
  end
end
