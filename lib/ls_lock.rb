class LsLock
  def self.parse_proc_locks(locks_file = "/proc/locks")
    locked_files = {}
    File.open(locks_file, "r") do |f|
      f.each_line do |line|
        out = line.split(/[:\s]/)
        inode = out[10].to_i
        pid = out[7].to_i
        locked_files[inode] ||= []
        locked_files[inode] << pid
      end
    end
    return locked_files
  end

  def self.locked_by_pid(dir)
    dir = File.join(dir, "**", "*")

    locked_files = parse_proc_locks
    pids = {}
    Dir.glob(dir).each do |file|
      inode = File.stat(file).ino
      if locked_files.has_key?(inode)
        locked_files[inode].each do |pid|
          pids[pid] ||= []
          pids[pid] << file
        end
      end
    end
    pids
  end
end
