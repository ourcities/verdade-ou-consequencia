module OmniAuth
  module Strategies
    class Meurio < OmniAuth::Strategies::OAuth2
      option :name, :meurio

      option :client_options, {
        :site => "http://meurio.org.br",
        :authorize_path => "/oauth/authorize"
      }

      info do
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meurio, ENV["MEURIO_ID"], ENV["MEURIO_SECRET"]
end