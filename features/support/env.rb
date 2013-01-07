require 'watir-webdriver'
require 'cucumber/ast/scenario'

def create_chrome_browser
  # switches opts: http://src.chromium.org/svn/trunk/src/chrome/common/chrome_switches.cc
  sw_opts = %w[
    --ignore-certificate-errors
    --disable-popup-blocking
    --disable-translate
  ]
  #--app-window-size=640,480

  #profile opts: http://src.chromium.org/svn/trunk/src/chrome/common/pref_names.cc
  pr_opts = Selenium::WebDriver::Chrome::Profile.new
  pr_opts['download.prompt_for_download'] = false
  pr_opts['download.default_directory'] = "#{File.dirname(__FILE__)}"

  Watir::Browser.new(:chrome, switches: sw_opts, profile: pr_opts)
end

browser = create_chrome_browser
Before do |scenario|
  #puts "Starting scenario #{scenario.title}"
  @browser = browser
end


After do |scenario|
  #puts "...............DONE:#{scenario.status}"
  if scenario.failed?
  end
end

at_exit do
  browser.close
end