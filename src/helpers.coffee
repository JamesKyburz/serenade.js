Helpers =
  extend: (target, source) ->
    for own key, value of source
      target[key] = value
  get: (model, value, format) ->
    if typeof(model?.get) is "function"
      model.get(value, format)
    else
      model?[value]
  set: (model, key, value) ->
    if model?.set
      model.set(key, value)
    else
      model[key] = value
  isArray: (object) ->
    Object::toString.call(object) is "[object Array]"

  pairToObject: (one, two) ->
    temp = {}
    temp[one] = two
    temp

  serializeObject: (object) ->
    if object and typeof(object.serialize) is 'function'
      object.serialize()
    else if Helpers.isArray(object)
      Helpers.serializeObject(item) for item in object
    else
      object

  getFunctionName: (fun) ->
    name = fun.modelName
    name or= fun.name
    name or= fun.toString().match(/\[object (.+?)\]/)?[1]
    name or= fun.toString().match(/function (.+?)\(\)/)?[1]
    name

  preventDefault: (event) ->
    if event.preventDefault
      event.preventDefault()
    else
      event.returnValue = false

Helpers.extend(exports, Helpers)
