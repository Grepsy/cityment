require 'rake'

ENV['APP_ROOT'] = File.dirname(__FILE__)
ENV['LIBDIR'] = ENV['APP_ROOT'].to_s + '/lib'

desc "Open an irb session preloaded with paths and modules"
task :console do
  sh "irb -I #{ENV['LIBDIR']} -r #{'cityment'} --simple-prompt"
end

task :test do
  test_files = ['unit/tc_endpoint.rb']
  test_files.each do |file|
    run_test file    
  end
end

def run_test file
  path = ENV['APP_ROOT'] + '/spec/' + file
  begin
    sh "ruby -I #{ENV['LIBDIR']} #{path}"
  rescue => e
    puts e.message
    # Hide e.backtrace
  end
end