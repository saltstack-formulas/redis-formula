require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe service("redis-server") do
  it { should be_enabled }
  it { should be_running }
end

describe port(6397) do
  it { should be_listening }
end
