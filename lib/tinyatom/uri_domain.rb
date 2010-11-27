require 'public_suffix_service'

# URI mixin that adds method to get domain.
module TinyAtom

  module URIDomain

    # Return the domain.
    def domain
      if host
        begin
          parsed = PublicSuffixService.parse(host.downcase)
          "#{parsed.sld}.#{parsed.tld}"
        rescue Exception
        end
      end
    end

  end

end
