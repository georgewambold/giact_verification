require "giact_verification/version"
require "giact_verification/configuration"
require "giact_verification/authenticate"
require "giact_verification/response"
require "giact_verification/errors"

module GiactVerification
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
