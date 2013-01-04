$(document).ready ->
  $('ol').after('<h2>你好，Nanana。Coffee Script is ready, :-D </h2>')


class Phonetic
  @create: (params) ->
    alert(params)
  constructor: (x) ->
    #alert("create obj from #{x}")
  id: undefined
  name: ''
  voice: 'http://voice.url/code'


myp = new Phonetic(t: 12)
alert(myp.voice)
alert("#{key} --> #{val}") for key,val of myp