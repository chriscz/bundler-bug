#!/usr/bin/env ruby
require "bundler/setup"

def executables_include?(gem_name, fname)
  x = Bundler.definition.specs.find { |s| s.name == gem_name }

  if x.executables.include?(fname)
    puts "✅ PASS: assert #{x.class}(name=#{gem_name.inspect}).executables.include?(#{fname.inspect})"
  else
    puts "❌ FAIL: assert #{x.class}(name=#{gem_name.inspect}).executables.include?(#{fname.inspect})"
    puts "         got executables: #{x.executables}"
  end
end

def check_executables(gem_name, *executables)
  executables.each do |executable_name|
    executables_include?(gem_name, executable_name)
  end
end

puts "* Running within #{Dir.pwd}"

puts "\n=== PATH-based include [local override applied]"
check_executables("bar-path", "bar-path-1", "bar-path-2")

puts "\n=== GIT-based include [local override applied]"
check_executables("bar-git", "bar-git-1", "bar-git-2")

puts "\n=== GIT-based include (with Dir.chdir fix applied inside of the gemspec) [local override applied]"
check_executables("bar-git-fixed", "bar-git-fixed-1", "bar-git-fixed-2")

puts "\n=== Gemfile.lock ==="
system("cat Gemfile.lock")

puts "\n=== bundle config ==="
system("bundle config")
