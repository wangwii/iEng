$(document).ready ->
  $('ol').after('<h2>Nanana 娜娜，你好吗？ 理论为核心那你干嘛那.Coffee Script is ready, :-D </h2>')


class Phonetic
  @create: (params) ->
    alert(params)
  constructor: (x) ->
    #alert("create obj from #{x}")
  id: undefined
  name: ''
  voice: 'http://voice.url/code'

