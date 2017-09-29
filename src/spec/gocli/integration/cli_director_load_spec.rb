require_relative '../spec_helper'

describe 'cli: director load test', type: :integration do
  with_reset_sandbox_before_each

  before(:each) do
    prepare_for_deploy

    1.times do |i|
      manifest_hash = Bosh::Spec::Deployments.simple_manifest
      manifest_hash['name'] = "deployment_name_#{i.to_s}"
      deploy_simple_manifest(manifest_hash: manifest_hash)
    end
  end

  it 'massively calls the director' do
    sandbox = Thread.current[:sandbox]
    threads = []
    failed = false
    failure_output = []

    220.times do
      if !failed
        threads << Thread.new {
          if !failed
            Thread.current[:sandbox] = sandbox
            output = bosh_runner.run('deployments', failure_expected: true)
            if output.match('502')
              failure_output << output
              failed = true
            end
          end
        }
      end
    end

    threads.each { |thr| thr.join }

    expect(failed).not_to be, "Failure messages: #{failure_output}"
  end
end
