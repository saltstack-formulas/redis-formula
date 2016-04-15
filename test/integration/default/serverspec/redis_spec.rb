require "serverspec"

set :backend, :exec

describe service("redis-server") do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end
