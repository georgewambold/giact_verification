require 'yaml'

class Configuration
  attr_accessor :api_username
  attr_accessor :api_password
  attr_reader :serviced_states, :serviced_countries, :valid_alternative_id_types, :valid_account_types

  def initialize
    @serviced_countries         = YAML.load_file(GiactVerification.root + '/serviced_countries.yml')
    @serviced_states            = YAML.load_file(GiactVerification.root + '/serviced_states.yml')
    @valid_alternative_id_types = YAML.load_file(GiactVerification.root + '/alternative_id_types.yml')
    @valid_account_types        = YAML.load_file(GiactVerification.root + '/valid_account_types.yml')
  end

  def invalid?
    api_username.nil? || api_password.nil?
  end
end
