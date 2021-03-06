# This file is managed centrally by modulesync
#   https://github.com/maestrodev/puppet-modulesync

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  c.mock_with :rspec
  c.hiera_config = File.expand_path(File.join(__FILE__, '../fixtures/hiera.yaml'))

  c.before(:each) do
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end

  c.default_facts = {
    operatingsystem: 'CentOS',
    operatingsystemrelease: '6.6',
    kernel: 'Linux',
    osfamily: 'RedHat',
    architecture: 'x86_64',
    clientcert: 'puppet.acme.com',
    os: {
      'architecture' => 'x86_64',
      'family'       => 'RedHat',
      'hardware'     => 'x86_64',
      'name'         => 'CentOS',
      'release'      => {
        'full'  => '6.6',
        'major' => '6',
        'minor' => '6'
      }
    }
  }.merge({})

  c.before do
    # avoid "Only root can execute commands as other users"
    Puppet.features.stubs(root?: true)
  end
end

shared_examples :compile, compile: true do
  it { is_expected.to compile.with_all_deps }
end
