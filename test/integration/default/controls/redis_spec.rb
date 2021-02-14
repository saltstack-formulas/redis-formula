# frozen_string_literal: true

control 'redis' do
  impact 1.0
  title 'Manage Redis Server'
  desc '
    Manage the redis server
  '
  tag 'redis', 'package'

  redis_service =
    case platform[:family]
    when 'redhat', 'fedora'
      'redis'
    when 'debian'
      'redis-server'
    when 'suse'
      'redis@default'
    end

  describe service(redis_service) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(6379) do
    it { should be_listening }
  end
end
