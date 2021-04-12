#!/usr/bin/env ruby
require 'bundler/setup'

def executables_include?(gem_name, fname)
  x = Bundler.definition.specs.find {|s| s.name == gem_name}
  if x.executables.include?(fname)
    puts "#{gem_name} INCLUDES: #{fname}"
  else
    puts "#{gem_name}   MISSES: #{fname}"
  end
end

def check_executables(gem_name)
  (1..2).each do |i|
    executables_include?(gem_name, "#{gem_name}-#{i}")
  end
end

puts "=== PATH-based include"
check_executables('bar-path')

puts "=== GIT-based include"
check_executables('bar-git')

puts "=== GIT-based include (with fix)"
check_executables('bar-git-fixed')

if File.exist?('config/application.rb')
  puts "=== GIT-based Engine include"
  check_executables('engine_git')
end
