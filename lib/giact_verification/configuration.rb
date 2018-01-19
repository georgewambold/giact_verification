class Configuration
  attr_accessor :api_username
  attr_accessor :api_password

  def invalid?
    api_username.nil? || api_password.nil?
  end
end
