require 'rake'
require 'coffee-script'
require 'webrick'

task :default => [:server]

desc "Startup a web server for development and listen coffeescript file changes"
task :server do
  root = File.dirname(File.expand_path __FILE__)
  port = (ENV['port'] || 3000).to_i
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

BASE_DIR = File.dirname(File.expand_path(__FILE__))
DIST_DIR = File.absolute_path(File.join(BASE_DIR, '_dist'))
COFFEE_DIR = File.join(BASE_DIR, 'coffee')
OUTPUT_DIR = File.join(BASE_DIR, 'javascripts')
desc "Push to the Github.com"
task :push => :sync_resources do
  #TODO...
  #chdir DIST_DIR
  #puts `git status`
  #puts "Do you want to push changes to the Github.com?[Y/n]"
  #confirm = STDIN.gets.chomp
  #unless confirm.downcase == 'n'
  #  puts 'git add .'
  #  puts `git commit -m 'this commit from automation rake task.'`
  #  puts `git pull`
  #  puts 'git push'
  #end
  #chdir BASE_DIR
end

task :sync_resources => :recompile_coffee do
  verbose(true)
  dirs = %w(javascripts js css stylesheets img phonetic)
  dirs.each do |dir|
    puts "Sync the #{dir} directory..."

    if File.exist?("#{DIST_DIR}/#{dir}")
      rm Dir.glob("#{DIST_DIR}/#{dir}/*")
    else
      Dir.mkdir("#{DIST_DIR}/#{dir}")
    end

    Dir.glob("#{BASE_DIR}/#{dir}/*").each { |f| cp(f, "#{DIST_DIR}/#{dir}/") }
  end

  puts 'Sync the index.html file...'
  cp("#{BASE_DIR}/index.html", "#{DIST_DIR}/")
end


task :recompile_coffee do
  Dir.glob("#{COFFEE_DIR}/*.coffee").each do |coffee_file|
    js_file = File.join(OUTPUT_DIR, "#{File.basename(coffee_file)}.js")
    puts "DEBUG ---> Compile coffee script #{File.basename(coffee_file)} to #{File.basename(js_file)}"
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
    cs_code = File.read(coffee_script) #, {encoding: "utf-8:utf-8"}
                                       #puts "(my codes:\n#{cs_code.encoding})-#{cs_code}"
    js_code = CoffeeScript.compile(cs_code)
  rescue => e
    js_code = %Q[alert("CoffeeScript compilation error: #{e}")]
  end
  #, {encoding: 'utf-8:utf-8'}
  File.open(js_script, 'wb') { |f| f.write(js_code) }
  #puts "new_codes:\n#{File.read(js_script, {encoding: 'utf-8'})}"
end