require 'yaml'

module GiactVerification
  class Configuration
    attr_accessor :api_username
    attr_accessor :api_password
    attr_accessor :sandbox_mode

    attr_reader :serviced_states, :serviced_countries, :valid_alternative_id_types, :valid_account_types

    def initialize
      @sandbox_mode = false

      @serviced_countries         = YAML.load_file(GiactVerification.config_directory + '/serviced_countries.yml')
      @serviced_states            = YAML.load_file(GiactVerification.config_directory + '/serviced_states.yml')
      @valid_alternative_id_types = YAML.load_file(GiactVerification.config_directory + '/alternative_id_types.yml')
      @valid_account_types        = YAML.load_file(GiactVerification.config_directory + '/valid_account_types.yml')
    end

    def giact_uri
      if sandbox_mode
        URI.parse('https://sandbox.api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx').freeze
      else
        URI.parse('https://api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx').freeze
      end
    end

    def invalid?
      api_username.nil? || api_password.nil?
    end

    def servicing?(state)
      serviced_states.include?(state)
    end

    def servicing_country?(country)
      serviced_countries.include?(country)
    end

    def accepts_id_type?(id_type)
      valid_alternative_id_types.include?(id_type)
    end

    def valid_account_type?(account_type)
      valid_account_types.include?(account_type)
    end
  end
end
