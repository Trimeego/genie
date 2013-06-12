expect = require("expect.js")
genie = require("../genie")
moment = require("moment")
_ = require("underscore")

describe "Genie", ->

  describe "Numbers", ->
    it "uses the min option", ->
      # since we are testing a random generator, we need to run it a few times
      for x in [1..20]
        obj = genie
          quantity:
            min: 1
        expect(obj.quantity).to.be.ok()
        expect(obj.quantity).to.be.within(1, 1000000)

    it "uses the max option", ->
      # since we are testing a random generator, we need to run it a few times
      for x in [1..20]
        obj = genie
          quantity:
            min: 1
            max: 3
        expect(obj.quantity).to.be.ok()
        expect(obj.quantity).to.be.within(1, 3)


    it "uses the range option", ->
      for x in [1..20]
        obj = genie
          quantity:
            range: [2,5]
        expect(obj.quantity).to.be.ok()
        expect(obj.quantity).to.be.within(2,5)


    it "uses the places option", ->
      hasplaces = false
      for x in [1..10]
        obj = genie
          quantity:
            min:1
            places: 2
        if obj.quantity%1 > 0
          hasplaces = true
      expect(hasplaces).to.be.ok()

    it "uses the round option", ->
      hasplaces = false
      for x in [1..10]
        obj = genie
          quantity:
            min:1000000
            min:10000000
            round: 1000000
        if obj.quantity%1000000 is 0
          rounded = true
      expect(rounded).to.be.ok()

  describe "Dates", ->
    it "uses the age option", ->
      # since we are testing a random generator, we need to run it a few times
      for x in [1..20]
        obj = genie
          dt:
            minAge: 1
            maxAge: 5
        expect(obj.dt).to.be.ok()
        expect(obj.dt.getTime()).to.be.within(moment().subtract('days', 5), moment().subtract('days', 1))


    it "uses the age option", ->
      # since we are testing a random generator, we need to run it a few times
      for x in [1..20]
        obj = genie
          dt:
            minAge: 1
            maxAge: 5
            format: 'MM/DD/YYYY'
        expect(obj.dt).to.be.ok()
        expect(obj.dt).to.match(/\d{2}\/\d{2}\/\d{4}/)


  describe "Patterns", ->

    it "uses the firstName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'firstName'
        expect(obj.target).to.be.ok()

    it "uses the lastName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'lastName'
        expect(obj.target).to.be.ok()

    it "uses the fullName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'fullName'
        expect(obj.target).to.be.ok()

    it "uses the zipCode option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'zipCode'
        expect(obj.target).to.be.ok()
        expect(obj.target).to.match(/\d{5}(\-\d{4})?/)

    it "uses the zipCode5 option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'zipCode5'
        expect(obj.target).to.be.ok()
        expect(obj.target).to.match(/\d{5}/)

    it "uses the zipCode9 option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'zipCode9'
        expect(obj.target).to.be.ok()
        expect(obj.target).to.match(/\d{5}\-\d{4}/)

    it "uses the city option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'city'
        expect(obj.target).to.be.ok()

    it "uses the streetName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'streetName'
        expect(obj.target).to.be.ok()

    it "uses the streetAddress option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'streetAddress'
        expect(obj.target).to.be.ok()

    it "uses the secondaryAddress option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'secondaryAddress'
        expect(obj.target).to.be.ok()

    it "uses the brState option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'brState'
        expect(obj.target).to.be.ok()

    it "uses the brStateAbbr option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'brStateAbbr'
        expect(obj.target).to.be.ok()

    it "uses the ukCounty option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'ukCounty'
        expect(obj.target).to.be.ok()

    it "uses the ukCountry option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'ukCountry'
        expect(obj.target).to.be.ok()

    it "uses the usState option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'usState'
        expect(obj.target).to.be.ok()

    it "uses the usStateAbbr option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'usStateAbbr'
        expect(obj.target).to.be.ok()
        expect(obj.target).to.match(/\w{2}/)


    it "uses the latitude option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'latitude'
        expect(obj.target).to.be.ok()

    it "uses the longitude option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'longitude'
        expect(obj.target).to.be.ok()

    it "uses the phoneNumber option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'phoneNumber'
        expect(obj.target).to.be.ok()

    it "uses the email option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'email'
        expect(obj.target).to.be.ok()

    it "uses the userName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'userName'
        expect(obj.target).to.be.ok()

    it "uses the domainName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'domainName'
        expect(obj.target).to.be.ok()

    it "uses the domainWord option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'domainWord'
        expect(obj.target).to.be.ok()

    it "uses the ipAddress option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'ipAddress'
        expect(obj.target).to.be.ok()

    it "uses the companyName option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'companyName'
        expect(obj.target).to.be.ok()

    it "uses the companySuffix option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'companySuffix'
        expect(obj.target).to.be.ok()

    it "uses the sentence option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'sentence'
        expect(obj.target).to.be.ok()

    it "uses the paragraph option", ->
      for x in [1..20]
        obj = genie
          target:
            pattern: 'paragraph'
        expect(obj.target).to.be.ok()


  describe "Arrays", ->
    it "uses the oneOf option", ->
      # since we are testing a random generator, we need to run it a few times
      for x in [1..20]
        obj = genie
          one:
            oneOf: [1,2,3]
        expect(obj.one).to.be.ok()
        expect(obj.one).to.be.within(1,3)

    it "uses the someOf option", ->
            
      # since we are testing a random generator, we need to run it a few times
      for x in [1..20]
        obj = genie
          one:
            someOf: [1,2,3,4,5,6,7,8,9,10]
        expect(obj.one).to.be.ok()
        expect(obj.one.length).to.be.within(1,10)

    it "uses the weightedSample option", ->
      results = 
        small: 0
        medium: 0
        large: 0

      for x in [1..1000]
        obj = genie
          one:
            weightedSample: [
              [10, "small"]
              [30, "medium"]
              [60, "large"]
            ]

        expect(obj.one).to.be.ok()
        results[obj.one] += 1

      expect(results.small).to.be.within(50, 150)
      expect(results.medium).to.be.within(250, 350)
      expect(results.large).to.be.within(550, 650)

  describe "Exixts", ->

    it "honors the exists value", ->
      for x in [1..20]
        obj = genie
          quantity:
            exists: ()->
              false
            min: 1
        expect(obj.quantity).to.not.be.ok()


  describe "Functions", ->

    it "uses an arbitrary function if passed", ->
      obj = genie
        target: ()->
          5
      expect(obj.target).to.be(5)

    it "applies correct function context", ->
      obj = genie
        ref:
          min: 1
          max: 5
        target: ()->
          this.ref + 1
      expect(obj.target).to.be(obj.ref+1)

    it "passes genie object into function with helpers", ->
      obj = genie
        ref:
          min: 1
          max: 5
        target: (genie)->
          
          expect(genie).to.not.be(null)
          expect(genie.oneOf).to.not.be(null)
          expect(genie.format).to.not.be(null)
          expect(genie.weightedSample).to.not.be(null)
          expect(genie.pattern).to.not.be(null)
      

  describe "Nested Nodes", ->

    it "generates child nodes or arbitrary depth if template nodes are specified", ->
      customer = genie
        name: 
          pattern: 'fullName'
        orders:
          min: 1
          max: 2
          template:
            orderNbr:
              format: '#######'
            orderDate:
              maxAge: 8
              minAge: 4
            products:
              min: 1
              max: 10
              template:
                itemNbr:
                  format: 'I-#####'
                description:
                  pattern: 'sentence'
                unitPrice:
                  min: 2.50
                  max: 15
                  places: 2
                quantity:
                  min: 1
                  max: 100
                extendedPrice: ()->
                  Math.round((this.unitPrice * this.quantity)*100)/100                  
            orderTotal: ()->
              total = _.reduce this.products, (memo, line) -> 
                memo + line.extendedPrice 
              , 0

      expect(customer.orders.length).to.be.greaterThan(0)
      expect(customer.orders[0].products.length).to.be.greaterThan(0)



