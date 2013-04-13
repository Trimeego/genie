Faker = require('Faker')
moment = require('moment')
_ = require("underscore")
fs = require('fs')



Faker.Genie = 
  fullName: ()-> Faker.Name.findName.apply(Faker.Name)
  ipAddress: ()-> Faker.Internet.ip.apply(Faker.Internet)
  zipCode5: ()-> Faker.Address.zipCodeFormat(0)
  zipCode9: ()-> Faker.Address.zipCodeFormat(1)
  brStateAbbr: ()-> Faker.Address.brState(true)
  usStateAbbr: ()-> Faker.Address.usState(true)
  weightedSample: (items)->
    itemMap = _.map items, (item)->
      o = 
        weight: item[0]
        value: item[1]

    total = _.reduce itemMap, (memo, item) -> 
        item.range = [memo, memo + item.weight - 0.0001]
        memo + item.weight
    , 0

    seed = Math.random() * total
    value = null
    for i in itemMap
      if seed >= i.range[0] and seed <= i.range[1]
        value = i.value
        break
    value

genie = (template)->
  obj = {}
  for c of template
    current = template[c]
    if _.isFunction(current)
      obj[c] = current.apply(obj)

    else if current.template
      # this is a nested Child Relationship
      min = current.min or current.range?[0] or 0
      max = current.max or current.range?[1] or 5 # 5 seems like a reasonable default      
      count = Faker.Helpers.randomNumber(max-min)
      arr = []
      for i in [1..count]
        arr.push genie(current.template)
      obj[c] = arr

    else if current.minAge or current.maxAge
      # this one is a date
      min = current.minAge || 0
      max = current.maxAge || 365
      if current.format
        obj[c] = moment().subtract('days', (min + Faker.Helpers.randomNumber(max-min))).format(current.format)
      else
        obj[c] = moment().subtract('days', (min + Faker.Helpers.randomNumber(max-min))).clone().toDate()
    else if current.min or current.max or current.range
      min = current.min or current.range?[0] or 0
      max = current.max or current.range?[1] or 1000000
      places = current.places or 0
      if places
        obj[c] = ((min*Math.pow(10, places)) + Faker.Helpers.randomNumber(max*Math.pow(10, places)-min*Math.pow(10, places)))/Math.pow(10, places)
      else
        obj[c] = min + Faker.Helpers.randomNumber(max-min)

    else if current.pattern
      # this is a standard pattern
      pattern = _.flatten((({func:Faker[n][f], context:Faker[n]} for f of Faker[n] when f is current.pattern) for n of Faker))    
      if pattern
        obj[c] = pattern[0].func.apply(pattern[0].context)

    else if current.format
      #this is a simple symbol replacement
      obj[c] = Faker.Helpers.replaceSymbolWithNumber(current.format)
        
    else if current.oneOf
      obj[c] = Faker.random.array_element(current.oneOf)

    else if current.weightedSample
      obj[c] = Faker.Genie.weightedSample(current.weightedSample)

    else
      console.log c
  obj

module.exports = genie
