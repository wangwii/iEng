require 'rake'

desc "Startup a web server for development and listen coffeescript file changes"
task :server do
  require 'webrick'
  root = File.dirname(File.expand_path __FILE__)
  port = (ENV['port'] || 80).to_i
  opts = WEBrick::Config::HTTP.merge({Port: port, DocumentRoot: root})
  server = WEBrick::HTTPServer.new opts

  %w[INT TERM].each do |sign|
    trap sign do
      server.shutdown
    end
  end
  coffee_compiler
  puts "......The WEBrick is running on #{root}....."
  server.start
end

desc "Push to the Github.com"
task :push do
  puts "...........TODO:..."
end

BASE_DIR = File.dirname(File.expand_path(__FILE__))
COFFEE_DIR = File.join(BASE_DIR, 'coffee')
OUTPUT_DIR = File.join(BASE_DIR, 'javascripts')
def coffee_compiler
  require 'coffee-script'
  require 'listen'
  puts "Watching CoffeeScript files in /#{COFFEE_DIR}"

  compiler = proc { |modified, added, remove|
    puts "----------------->coffee files change, compile to #{OUTPUT_DIR}:"
    puts "modified: #{modified}"
    puts "added: #{added}"
    puts "remove: #{remove}"
  }
  listener = Listen.to(COFFEE_DIR, filter: /\.coffee$/)
  listener.change(&compiler)
  listener.start(false)
end

#def recompile_coffee
#  puts "Changes detected, recompiling"
#  compile_coffee
#end
#
#def compile_coffee
#  code = StringIO.new
#  Dir.glob("#{COFFEE_DIR}/**/*.coffee").each do |f|
#    code << IO.read(f)
#  end
#  Dir.mkdir('js') unless Dir.exists? 'js'
#  File.open(OUTPUT_DIR, 'w') do |f|
#    f.write CoffeeTaster.compile code.string
#  end
#end