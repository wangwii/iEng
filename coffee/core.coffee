callback_method_names = ['extended', 'included']

class Module
  ###
  comment for the extend
  ###
  @extend: (obj) ->
    @[key] = value for key, value of obj when key not in callback_method_names

    obj.extended?.apply(this)
    this

  ###
  comment for the include
  ###
  @include: (obj) ->
    #this.prototype[key] = value
    @::[key] = value for key, value of obj when key not in callback_method_names

    obj.included?.apply(@)
    this
