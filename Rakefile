require 'rake'
require 'coffee-script'
require 'webrick'

desc "Startup a web server for development and listen coffeescript file changes"
task :server do
  root = File.dirname(File.expand_path __FILE__)
  port = (ENV['port'] || 80).to_i
  config = {
    Port: port, DocumentRoot: root,
    StartCallback: proc { puts "WEBrick working on #{root}" },
    StopCallback: proc { puts "WEBrick stop finished." },
    RequestCallback: proc { |req| sync_coffee req }
  }
  server = WEBrick::HTTPServer.new config

  %w[INT TERM].each do |sign|
    trap sign do
      server.shutdown
    end
  end
  server.start
end

desc "Push to the Github.com"
task :push do
  puts "...........TODO:..."
end

## private method
BASE_DIR = File.dirname(File.expand_path(__FILE__))
COFFEE_DIR = File.join(BASE_DIR, 'coffee')
OUTPUT_DIR = File.join(BASE_DIR, 'javascripts')

def sync_coffee(req)
  req_path = req.path.to_s
  return unless req_path.respond_to? :end_with?
  return unless req_path.end_with?('.coffee.js')

  file_name = File.basename(req_path)
  coffee_file = File.basename(file_name, '.js')
  coffee_file_path = File.join(COFFEE_DIR, coffee_file)
  js_file_path = File.join(OUTPUT_DIR, file_name)

  if File.exist? coffee_file_path
    if File.exist?(js_file_path)
      js_modify, cs_modify = File.mtime(js_file_path), File.mtime(coffee_file_path)
      if js_modify > cs_modify
        puts "DEBUG ---> The #{file_name} is already latest version."
        return
      end
    end
    compile_coffee_script(coffee_file_path, js_file_path)
  else
    puts "WARN the coffee script file does not exist. (#{coffee_file_path})"
  end
end

def compile_coffee_script(coffee_script, js_script)
  begin
    js_code = CoffeeScript.compile(File.read(coffee_script))
  rescue => e
    js_code = %Q[alert("CoffeeScript compilation error: #{e}")]
  end
  File.open(js_script, 'w') { |f| f.write(js_code) }
end