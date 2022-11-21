require 'confidante'
require 'rake_terraform'
require 'rake_docker'
require 'rake_ssh'

configuration = Confidante.configuration

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '1.3.1'
)

namespace :bootstrap do
  RakeTerraform.define_command_tasks(
      configuration_name: 'bootstrap',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'bootstrap'))

    t.source_directory = 'infra/bootstrap'
    t.work_directory = 'build'

    t.state_file =
        File.join(
            Dir.pwd,
            "state/bootstrap/#{args.deployment_identifier}.tfstate")
    t.vars = configuration.vars
  end
end

namespace :domain do
  RakeTerraform.define_command_tasks(
      configuration_name: 'domain',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'domain'))

    t.source_directory = 'infra/domain'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :certificate do
  RakeTerraform.define_command_tasks(
      configuration_name: 'certificate',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'certificate'))

    t.source_directory = 'infra/certificate'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end
