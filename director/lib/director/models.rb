module Bosh::Director
  module Models
    VALID_ID = /^[-a-z0-9_.]+$/i

    autoload :CompiledPackage, "director/models/compiled_package"
    autoload :Deployment, "director/models/deployment"
    autoload :Instance, "director/models/instance"
    autoload :Package, "director/models/package"
    autoload :Release, "director/models/release"
    autoload :ReleaseVersion, "director/models/release_version"
    autoload :Stemcell, "director/models/stemcell"
    autoload :Template, "director/models/template"
    autoload :Task, "director/models/task"
    autoload :User, "director/models/user"
    autoload :Vm, "director/models/vm"

  end
end


Sequel::Model.plugin :validation_helpers

Sequel::Model.raise_on_typecast_failure = false

[:exact_length, :format, :includes, :integer, :length_range, :max_length,
 :min_length, :not_string, :numeric, :type, :presence, :unique].each do |validation|
  Sequel::Plugins::ValidationHelpers::DEFAULT_OPTIONS[validation][:message] = validation
end
Sequel::Plugins::ValidationHelpers::DEFAULT_OPTIONS[:max_length][:nil_message] = :max_length
