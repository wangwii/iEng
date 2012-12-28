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
    StopCallback: proc { puts "WEBrick stop finished." }
    #,RequestCallback: proc { |req| sync_coffee req }
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

BASE_DIR = File.dirname(File.expand_path(__FILE__))
COFFEE_DIR = File.join(BASE_DIR, 'coffee')
OUTPUT_DIR = File.join(BASE_DIR, 'javascripts')
task :recompile_coffee do
  Dir.glob("#{COFFEE_DIR}/*.coffee").each do |coffee_file|
    js_file = File.join(OUTPUT_DIR, "#{File.basename(coffee_file)}.js")
    puts "DEBUG ---> Sync coffee script #{File.basename(coffee_file)} to #{File.basename(js_file)}"
    compile_coffee_script(coffee_file, js_file)
  end
end

## private method
def sync_coffee(req)
  req_path = req.path.to_s
  return unless req_path.respond_to? :end_with?
  return unless req_path.end_with?('.coffee.js')

  file_name = File.basename(req_path)
  coffee_file = File.basename(file_name, '.js')
  coffee_file_path, js_file_path = File.join(COFFEE_DIR, coffee_file), File.join(OUTPUT_DIR, file_name)

  compile_coffee_script(coffee_file_path, js_file_path)
end

def compile_coffee_script(coffee_script, js_script)
  #check params
  unless File.exist? coffee_script
    puts "WARN ---> The coffee script file does not exist. (#{coffee_script})"
    return
  end
  if File.exist?(js_script) && File.mtime(js_script) > File.mtime(coffee_script)
    puts "DEBUG ---> The #{js_script} is already latest version."
    return
  end

  #compile and write to js file.
  begin
    js_code = CoffeeScript.compile(File.read(coffee_script))
  rescue => e
    js_code = %Q[alert("CoffeeScript compilation error: #{e}")]
  end
  File.open(js_script, 'w') { |f| f.write(js_code) }
end