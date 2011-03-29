require 'rake'

ENV['APP_ROOT'] = File.dirname(__FILE__)
ENV['LIBDIR'] = ENV['APP_ROOT'].to_s + '/lib'

desc "Open an irb session preloaded with paths and modules"
task :console do
  sh "irb -I #{ENV['LIBDIR']} -r #{'cityment'} --simple-prompt"
end

desc "Run all unit tests"
task :test do
  begin
    sh "turn -I #{ENV['LIBDIR']} -n 'spec/unit/tc_*.rb' -m"
  rescue => e
    e.message
  end  
end

desc "Run a single test case"
task :test_case, :name do |t, args|
  begin
    sh "ruby -I:lib spec/unit/tc_#{args[:name]}.rb"
  rescue => e
    e.message
  end
end