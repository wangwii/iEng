#encoding=utf-8
Given /^我要打开 "(.*?)" 进行搜索$/ do |search_url|
  @browser.goto search_url
end

When /^我输入 "(.*?)"$/ do |keyword|
  @browser.text_field(name: 'q').set keyword
end

And /^按下"(.*?)"按钮$/ do |btn_name|
  @browser.button(name: 'btnK').click
end

Then /^我应该看到包含以下内容的页面$/ do |string|
  @browser.text.include? string
end