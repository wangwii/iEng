#language: zh-CN
Feature: 开启Cucumber测试功能
  为了学习Cucumber并使用在项目开发中
  作为一个开发者
  我想要在运行cucumber测试时，启动浏览器并访问一个页面，然后再操纵页面里的元素

  Scenario: 打开某个网站并输入关键字进行搜索
    Given 我要打开 "www.baidu.com" 进行搜索
    When 我输入 "cucumber"
    And 按下"搜索"按钮
    Then 我应该看到包含以下内容的页面
    """
    cucumber
    """