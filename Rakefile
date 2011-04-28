require 'rake'

task :update => :insert

desc "Insert crawled items into database"
task :insert => :crawl do
  require 'cityment'
  Cityment.insert
end

desc "Crawl AT5 API for news items"
task :crawl => :enviroment do
  require 'cityment'
  Cityment.crawl
end

desc "Loads enviroment variables"
task :enviroment do
  appdir = File.dirname(__FILE__)
  
  # Determine lib paths
  libdirs = FileList[File.join(appdir, '**', 'lib')]
  ENV['RUBYLIB'] = libdirs.join(':')

  libdirs.each do |path|
    $LOAD_PATH.unshift path.to_s
  end
  
  # Set other paths
  
  ENV['APP_ROOT'] = appdir
  ENV['CFGPATH'] = File.join(appdir, 'config')
  ENV['DATADIR'] = ENV['APP_ROOT'].to_s + '/data/cityment'
  
  # Load external rake tasks
  #Dir['tasks/*.rake'].each{|f| import(f) }  
end

desc "Open an irb session preloaded with paths and modules"
task :console => :enviroment do
  sh "irb -I #{ENV['RUBYLIB']} -r #{'cityment'} --simple-prompt"
end

desc "Run all unit tests"
task :test => :enviroment do
  begin
    sh "turn -I #{ENV['RUBYLIB']} -n 'spec/unit/tc_*.rb' -m"
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