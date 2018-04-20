control 'redis' do
  impact 1.0
  title 'Manage Redis Server'
  desc '
    Manage the redis server
  '
  tag 'redis', 'package'

  case os[:family]
  when 'redhat'
    redis_service = 'redis'
  when 'debian'
    redis_service = 'redis-server'
  end

  describe service(redis_service) do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(6379) do
    it { should be_listening }
  end
end
