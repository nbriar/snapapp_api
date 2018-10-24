require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |rb| require(rb) }

require 'webmock/minitest'
WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  def self.test(test_name, &block)
    return super if block.nil?

    cassette = [name, test_name].map do |str|
      str.underscore.gsub(/[^A-Z]+/i, "_")
    end.join("/")

    super(test_name) do
      VCR.use_cassette(cassette) do
        instance_eval(&block)
      end
    end
  end
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    stub_request(:get, "https://briarapp.auth0.com/.well-known/jwks.json").
    to_return(:status => 200, :body => '{
      "keys": [{
        "alg": "RS256",
        "kty": "RSA",
        "use": "sig",
        "x5c": [
          "MIIC/zCCAeegAwIBAgIJBmh2TCFt69+tMA0GCSqGSIb3DQEBCwUAMB0xGzAZBgNVBAMTEmJyaWFyYXBwLmF1dGgwLmNvbTAeFw0xODA0MjEyMTQ4MDhaFw0zMTEyMjkyMTQ4MDhaMB0xGzAZBgNVBAMTEmJyaWFyYXBwLmF1dGgwLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALqdCn1xCC0QP49sug7lxtm95vAdVVAm/SfXqf/ilemp7EgnsPjgv3/nP3OSSDcA89RWIIYCcitCKsjZ32onuAQZe8cdIly6Vw9R30cAFWWCB/LmRj2sW9mP74n5fz5OjYUTxmq4gRN8slxZsxQr4VROSpbo4yEt5QwbuWPi2wmCy7an2LVQQjhvZELbSKBP6I84tbqfoNf6T6rnxtn+kv+fvx0oLdVNCQ6apPZC7YNJTVez6UcSVdarvcs2yvmUrzUla5tBZEZU1qaWpYoXYakraITfWS3zXYj2khnQQUqaRDsTtsoGGondSbKBvPpQv1EohTWsb6FZox/x83gKmrMCAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU4qpmvXS/pPWRNapbb04VvHttmZkwDgYDVR0PAQH/BAQDAgKEMA0GCSqGSIb3DQEBCwUAA4IBAQCpxidm1yBIqpSEuPWnDvQICPX3N4yocTzcFvQeSonez2r7N0Rc+JFW72RQXXznt6Vxxdj37oZqRnQjjqvicrbHDhQ3BXs954fMLgDvaoHr3D5kAJDR4Uk+w0HGuz0bfkmZ4tismiqcpE5Bhzq1gyAhHUHjmIsks2ubQG991NFQvzRkBjFFf9O6aBkh316HLdGrxELToDEoldDgjSFY965VUnHtIIgoh2tnQLNtckESGw1hYd/fdixkXobVjQW0svB65cu1ovStbiURV5bVtc5lzFvQuVTiIRngez1vMOc2X87gm5PnYpHbBDileCzs9M92eEMZGo9b4LwW8MwzUO3Z"
        ],
        "n": "up0KfXEILRA_j2y6DuXG2b3m8B1VUCb9J9ep_-KV6ansSCew-OC_f-c_c5JINwDz1FYghgJyK0IqyNnfaie4BBl7xx0iXLpXD1HfRwAVZYIH8uZGPaxb2Y_vifl_Pk6NhRPGariBE3yyXFmzFCvhVE5KlujjIS3lDBu5Y-LbCYLLtqfYtVBCOG9kQttIoE_ojzi1up-g1_pPqufG2f6S_5-_HSgt1U0JDpqk9kLtg0lNV7PpRxJV1qu9yzbK-ZSvNSVrm0FkRlTWppalihdhqStohN9ZLfNdiPaSGdBBSppEOxO2ygYaid1JsoG8-lC_USiFNaxvoVmjH_HzeAqasw",
        "e": "AQAB",
        "kid": "MkZCRjM5RDhDQjRDQzNERjQwMjVDQTYyNDE3Qzk0MkJEMDkyNjcwQQ",
        "x5t": "MkZCRjM5RDhDQjRDQzNERjQwMjVDQTYyNDE3Qzk0MkJEMDkyNjcwQQ"
      }]
    }', :headers => {})
  end

  def external_user_id
    "DXfdbqK0LFNO0rnSGLbagYBhxZ9WESKV@clients"
  end

  def auth_header
    {
      "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ik1rWkNSak01UkRoRFFqUkRRek5FUmpRd01qVkRRVFl5TkRFM1F6azBNa0pFTURreU5qY3dRUSJ9.eyJpc3MiOiJodHRwczovL2JyaWFyYXBwLmF1dGgwLmNvbS8iLCJzdWIiOiJEWGZkYnFLMExGTk8wcm5TR0xiYWdZQmh4WjlXRVNLVkBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly90ZXh0LWRlcG90LWFwaS5oZXJva3VhcHAuY29tLyIsImlhdCI6MTUyNTIzMjgzNCwiZXhwIjoxNTI1MzE5MjM0LCJhenAiOiJEWGZkYnFLMExGTk8wcm5TR0xiYWdZQmh4WjlXRVNLViIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyJ9.OVlgE0wEfDYbuxDRPz9yfRGq2niXCNuJODMDaHrCWGrNX9bU6X9e2KU9zp2Ov3_nB-hiRs63592NvkeM7Okmq1zheHhqMOkCJxcb9cfut7LswRUoLaKtciKc478rmcCgZYcmGY7xUrhh_sYSYln04wpqVtUYK0OnR9ChuvDt4PvL19HPwVZEWETK-MV8kwAJt-v-g8BhGKBL3kgPtwLqNDbPGYRk_U-IcOKV-3QbB4D1DPZXpSNTxMqHZWaBEq373VZRssAmjGKwSVFwUbBqFUH3gVx_zTcsPArwtE5_YQ-UKyGQhlDwmhrwVVvD17js9MaoKwPIpaa_2guCa-p73w"
    }
  end

  # Add more helper methods to be used by all tests here...
end
