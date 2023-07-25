ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require_relative "./test_base"
require "rails/test_help"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
