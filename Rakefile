require 'rake'

ENV['APP_ROOT'] = File.dirname(__FILE__)
ENV['LIBDIR'] = ENV['APP_ROOT'].to_s + '/lib'

desc "Open an irb session preloaded with paths and modules"
task :console do
  sh "irb -I #{ENV['LIBDIR']} -r #{'feed'} --simple-prompt"
end
