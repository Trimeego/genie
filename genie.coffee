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
  pattern: (pattern)->
    fakerPattern = _.flatten((({func:Faker[n][f], context:Faker[n]} for f of Faker[n] when f is pattern) for n of Faker))    
    if fakerPattern and fakerPattern.length > 0
      fakerPattern[0].func.apply(fakerPattern[0].context)
    else
      throw new Error("invalid pattern: #{pattern}")
  format: (format)->
    Faker.Helpers.replaceSymbolWithNumber(format)    

  oneOf: (items)->
    Faker.random.array_element(items)

  someOf: (items, min, max)->
    count = min + Faker.Helpers.randomNumber(min-max)
    if items.length <= count
      items
    else
      excluded = []    
      excludeCount = items.length - count
      while excluded.length < excludeCount
        itemsLeft = _.without(items, excluded)
        candidate = Faker.random.array_element(itemsLeft)
        excluded.push candidate

      selected = _.without(items, excluded)


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
    if not current.exists or current?.exists.apply obj, [Faker.Genie]
      if _.isFunction(current)
        obj[c] = current.apply(obj, [Faker.Genie])

      else if current.template
        min = current.min or current.range?[0] or 0
        max = current.max or current.range?[1] or 5 # 5 seems like a reasonable default   

        if not current.min and not current.max 
          obj[c] = genie(current.template)
        else  
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
        if current.round
          obj[c] = Math.floor(obj[c] / current.round) * current.round

      else if current.pattern
        # this is a standard pattern
        obj[c] = Faker.Genie.pattern.apply(obj, [current.pattern])
      else if current.format
        #this is a simple symbol replacement
        obj[c] = Faker.Genie.format.apply(obj, [current.format])
          
      else if current.someOf
        obj[c] = Faker.Genie.someOf.apply(obj, [current.someOf, 1, current.someOf.length])

      else if current.oneOf
        obj[c] = Faker.Genie.oneOf.apply(obj, [current.oneOf])

      else if current.weightedSample
        obj[c] = Faker.Genie.weightedSample.apply(obj, [current.weightedSample])

  obj

module.exports = genie
