module GiactVerification

  def self.configuration
    @configuration ||= GiactVerification::Configuration.new
  end

  def self.configure
    yield configuration
  end

  # This is class level method delegation -- Really unpleasant.
  class << self
    require 'forwardable'
    extend ::Forwardable


    def_delegators :configuration,
      :servicing_country?,
      :servicing?,
      :accepts_id_type?,
      :valid_account_type?,
      :giact_uri
  end

  def self.ready_for_request?
    if configuration.invalid?
      raise ConfigurationError
    else
      true
    end
  end

  def self.root
    File.dirname __dir__
  end

  def self.config_directory
    File.join(root, 'lib', 'giact_verification', 'etc')
  end

  def self.inquiry_template_directory
    File.join(root, 'lib', 'giact_verification', 'templates', 'inquiry.xml.erb')
  end
end

require "giact_verification/version"
require "giact_verification/configuration"
require "giact_verification/authenticate"
require "giact_verification/response"
require "giact_verification/response_parser"
require "giact_verification/extract_inquiry_result"
require "giact_verification/request"
require "giact_verification/xml_to_hash"
require "giact_verification/errors"
require "giact_verification/inquiry_template_renderer"
require "giact_verification/validators/customer_validator"
require "giact_verification/validators/check_validator"
require "giact_verification/models/check"
require "giact_verification/models/customer"
require "giact_verification/decorators/decorate_hash"
require "giact_verification/decorators/giact_soap_decorator"
