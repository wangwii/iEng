#encoding=utf-8

# Test for run command
def git_pull
  #lookup temp file dir
  tmp_dir = ENV[%w[TMPDIR TMP TEMP].find { |name| File.directory?(ENV[name].to_s) }.to_s]
  return unless File.directory?(tmp_dir.to_s)

  current_dir = Dir.pwd
  puts "current_dir: #{current_dir}"

  #
  work_dir = "#{tmp_dir}/git_work_dir"
  Dir.mkdir(work_dir) unless File.exist?(work_dir)
  Dir.chdir(work_dir)
  puts "git temporary work dir: #{work_dir}"
  puts `git clone git@github.com:WangweiXian/iEng.git`
  puts `git checkout -b gh-pages`
  puts `git branch --set-upstream gh-pages origin/gh-pages`
end

git_pull


__END__

js_path = 'E:/MyWorks/iEng/javascripts/main.coffee.js'
cs_path = 'E:/MyWorks/iEng/coffee/main.coffee'
compile_coffee_script(cs_path, js_path)

# Test for Listen
#require 'listen'
#def listen
#  listener = Listen.to('E:/MyWorks/iEng', polling_fallback_message: 'WARNING: Listen fallen back to polling.')
#  callback = proc { |modified, added, remove|
#    puts "modified:...............:#{modified}"
#    puts "added:...............:#{added}"
#    puts "remove:...............:#{remove}"
#  }
#  puts "..............:(#{callback.class.name})"
#  listener.change(&callback)
#  listener.start(false)
#  puts "~~~~~,输入任意键退出.."
#  gets()
#end