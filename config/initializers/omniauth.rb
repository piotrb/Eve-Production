require 'openid/store/memcache'

OpenID::Store::Memcache

# monkey patch to make openid/store/memcache play nice with dalli
module OpenID
  module Store
    class Memcache < Interface

      def use_nonce(server_url, timestamp, salt)
        return false if (timestamp - Time.now.to_i).abs > Nonce.skew
        ts = timestamp.to_s # base 10 seconds since epoch
        nonce_key = key_prefix + 'N' + server_url + '|' + ts + '|' + salt
        result = @cache_client.add(nonce_key, '', expiry(Nonce.skew + 5))
        if result.is_a? String
          return !!(result =~ /^STORED/)
        else
          return result == true
        end
      end

      def delete(key)
        result = @cache_client.delete(key)
        if result.is_a? String
          return !!(result =~ /^DELETED/)
        else
          return result == true
        end
      end

    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Memcache.new(Dalli::Client.new), :name => "google", :identifier => 'https://www.google.com/accounts/o8/id'
end