# frozen_string_literal: true

require 'confidante'
require 'rake_docker'
require 'rake_factory/kernel_extensions'
require 'rake_ssh'
require 'rake_terraform'
require 'ruby_terraform/output'
require 'rubocop/rake_task'

require_relative 'lib/version'

configuration = Confidante.configuration
version = Version.from_file('build/version')

RakeTerraform.define_installation_tasks(
  path: File.join(Dir.pwd, 'vendor', 'terraform'),
  version: '1.3.1'
)

RuboCop::RakeTask.new

namespace :build do
  namespace :code do
    desc 'Run all checks on the build code'
    task check: [:rubocop]

    desc 'Attempt to automatically fix issues with the build code'
    task fix: [:'rubocop:autocorrect_all']
  end
end

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
        "state/bootstrap/#{args.deployment_identifier}.tfstate"
      )
    t.vars = configuration.vars
  end
end

namespace :repository do
  RakeTerraform.define_command_tasks(
    configuration_name: 'repository',
    argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration =
      configuration
      .for_scope(
        { deployment_identifier: args.deployment_identifier }
          .merge(role: 'repository')
      )

    t.source_directory = 'infra/repository'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :image do
  RakeDocker.define_image_tasks(
    image_name: 'open-policy-agent-aws-lambda',
    argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration =
      configuration
      .for_scope(args.to_h.merge(role: 'repository'))

    t.work_directory = 'build/images'

    t.copy_spec = %w[
      images/open-policy-agent-aws-lambda/Dockerfile
      images/open-policy-agent-aws-lambda/policies
    ]
    t.create_spec = [
      { content: version.to_s, to: 'VERSION' },
      { content: version.to_docker_tag, to: 'TAG' }
    ]

    t.repository_name = 'infrablocks/open-policy-agent-aws-lambda'
    t.repository_url = dynamic do
      RubyTerraform::Output.for(
        name: 'repository_url',
        raw: true,
        source_directory: 'infra/repository',
        work_directory: 'build',
        backend_config: configuration.backend_config
      )
    end

    t.credentials = dynamic do
      RakeDocker::Authentication::ECR.new do |c|
        c.region = configuration.region
        c.registry_id = RubyTerraform::Output.for(
          name: 'registry_id',
          raw: true,
          source_directory: 'infra/repository',
          work_directory: 'build',
          backend_config: configuration.backend_config
        )
      end.call
    end

    t.platform = 'linux/amd64'

    t.tags = [version.to_docker_tag]
  end
end

namespace :lambda do
  RakeTerraform.define_command_tasks(
    configuration_name: 'lambda',
    argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration =
      configuration
      .for_scope(
        { deployment_identifier: args.deployment_identifier }
          .merge(role: 'lambda')
      )
      .for_overrides(
        image_tag: version.to_docker_tag
      )

    t.source_directory = 'infra/lambda'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :api_gateway do
  RakeTerraform.define_command_tasks(
    configuration_name: 'api-gateway',
    argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration =
      configuration
      .for_scope(
        { deployment_identifier: args.deployment_identifier }
          .merge(role: 'api_gateway')
      )

    t.source_directory = 'infra/api_gateway'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end
