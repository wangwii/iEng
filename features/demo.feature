#language: zh-CN
功能:开启Cucumber测试功能
  为了学习Cucumber并使用在项目开发中
  作为一个开发者
  我想要在运行cucumber测试时，启动浏览器并访问一个页面，然后再操纵页面里的元素

  场景:打开某个网站并输入关键字进行搜索
    假如 我要打开 "www.google.com/ncr" 进行搜索
    当 我输入 "cucumber"
    并且 按下"搜索"按钮
    那么 我应该看到包含以下内容的页面
    """
    cucumber
    """