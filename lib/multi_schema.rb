require "active_support/autoload"
require "multi_schema/version"

module MultiSchema
  extend ActiveSupport::Autoload

  autoload :Behaviors

  include Behaviors
  extend Behaviors
end
