require 'httparty'
require_relative 'requests/generate_signature'

module Mobilepay
    # Security requests
    class Security
        include HTTParty
        include Mobilepay::Requests::GenerateSignature

        base_uri 'https://api.mobeco.dk/merchantsecurity/api'
        format :json

        attr_reader :headers, :uri

        def initialize(args = {})
            @headers = { 'Ocp-Apim-Subscription-Key' => args[:subscription_key], 'Content-Type' => 'application/json' }
            @uri = '/publickey'
        end

        def public_key
            response = self.class.get(uri, query: {}, headers: headers)
            response.parsed_response
        end
    end
end
