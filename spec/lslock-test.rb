#!/usr/bin/env ruby

require 'fileutils'

dir = '/tmp/lslock-test'

job_dirs = ['foo', 'bar', 'baz']

job_dirs.each do |jdir|
  FileUtils.mkdir_p("#{dir}/#{jdir}") rescue nil
  f = File.open("#{dir}/#{jdir}/#{jdir}", "w+")
  f.flock(File::LOCK_EX)
end

fork do
  FileUtils.mkdir_p("#{dir}/forked") rescue nil
  f = File.open("#{dir}/forked/forked", "w+")
  f.flock(File::LOCK_EX)

  while(true) do
  end
end

while(true) do
end
