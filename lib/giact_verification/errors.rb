module GiactVerification
  class ArgumentError < RuntimeError; end
  class ConfigurationError < RuntimeError; end
  class HTTPError < StandardError;end;
  class MalformedXmlError < StandardError;end;
end
