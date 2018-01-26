module GiactVerification
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.ready_for_request?
    if configuration.invalid?
      raise ConfigurationError
    else
      return true
    end
  end

  def self.servicing?(state)
    configuration.serviced_states.include?(state)
  end

  def self.servicing_country?(country)
    configuration.serviced_countries.include?(country)
  end

  def self.accepts_id_type?(id_type)
    configuration.valid_alternative_id_types.include?(id_type)
  end

  def self.valid_account_type?(account_type)
    configuration.valid_account_types.include?(account_type)
  end

  def self.root
    File.dirname __dir__
  end

  def self.template_directory
    File.join(root, 'lib', 'giact_verification', 'templates')
  end
end

require "giact_verification/version"
require "giact_verification/configuration"
require "giact_verification/authenticate"
require "giact_verification/response"
require "giact_verification/request"
require "giact_verification/errors"
require "giact_verification/template_renderer"
require "giact_verification/validators/customer_validator"
require "giact_verification/validators/check_validator"
