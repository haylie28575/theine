require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task default: :test

task :clear_vcr do
  `rm test/vcr/cassettes/*.yml`
end
