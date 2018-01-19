require "giact_verification/version"
require "giact_verification/configuration"

module GiactVerification
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
