require "ls_lock"

describe LsLock do
  it "parse /proc/locks" do
    locked_files = LsLock.parse_proc_locks("spec/locks_example")
    expect(locked_files[74341340]).to eql([55134,55135])
    expect(locked_files[109]).to eql([8])
  end

  it "get locks for given path" do
    pid = Process.spawn "spec/lslock-test.rb"
    sleep 2
    locked_by_pid = LsLock.locked_by_pid('/tmp/lslock-test')
    expect(locked_by_pid.first[1]).to eql(['/tmp/lslock-test/foo/foo','/tmp/lslock-test/bar/bar','/tmp/lslock-test/baz/baz'])
    Process.kill("KILL", pid)
  end
end
