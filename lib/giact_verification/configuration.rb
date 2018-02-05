require 'yaml'

module GiactVerification
  class Configuration
    attr_accessor :api_username
    attr_accessor :api_password

    attr_reader :serviced_states, :serviced_countries, :valid_alternative_id_types, :valid_account_types, :supported_request_types

    def initialize
      @serviced_countries         = YAML.load_file(GiactVerification.root + '/serviced_countries.yml')
      @serviced_states            = YAML.load_file(GiactVerification.root + '/serviced_states.yml')
      @valid_alternative_id_types = YAML.load_file(GiactVerification.root + '/alternative_id_types.yml')
      @valid_account_types        = YAML.load_file(GiactVerification.root + '/valid_account_types.yml')
      @supported_request_types    = YAML.load_file(GiactVerification.root + '/supported_request_types.yml')
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

    def supports_request_type?(request_type)
      supported_request_types.include?(request_type)
    end

    def accepts_id_type?(id_type)
      valid_alternative_id_types.include?(id_type)
    end

    def valid_account_type?(account_type)
      valid_account_types.include?(account_type)
    end
  end
end
