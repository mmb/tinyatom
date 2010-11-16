require 'uri'

class URI::Generic

  # Add domain method to URI.
  def domain
    if (host and (d = host[/[a-z\d-]+\.[a-z]{2,}(\.[a-z]{2})?$/]))
      d.downcase
    end
  end

end
