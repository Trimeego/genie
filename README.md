# Genie


A simple object generator for ginning up realistic looking fake data.  Works for all of your fake data needs.

## Huh?

Sometimes you just need some realistic looking data.  Having developed using MongoDB, for some time, I wanted a simple way to generate realistic looking data that I could shove into MongoDB collections.  Don't use MongoDB? That is OK.  Genie simply generates a random object using a template the you provide.  You lather, rinse repeat as you see fit to get the data that you want and then store it anywhere you want.  Of course, since Genie is particularly good at generating rich, deeply nested, data structures, JSON is a natural medium, but, seriously, that is up to you.

## Installation

```
npm install genie
```

## Examples

I use coffeescript a lot and I like it.  As such, the examples are in coffeescript.  For those of you who favor pure javascript, no problem, genie comes compiled to js with tests and examples compiled to js, too.  So just have a look at ```examples/*.js```

### Something Simple

Say you needed to generate some customer records.  Your template might look like this.


```
genie = require('../genie')

template = 
  name: 
    pattern: 'companyName'
  address1: 
    pattern: 'streetAddress'
  city: 
    pattern: 'city'
  state: 
    pattern: 'us_state_abbr'
  zip: 
    pattern: 'zipCode'
  employees: 
    min: 12
    max: 150

customer = genie(template)

```

This would generate a records that looked something like this


```
{ name: 'Fadel, Schmidt and Maggio',
  address1: '06356 Howell Cove',
  city: 'East Darren',
  state: 'CT',
  zip: '14688-7682',
  employees: 64
}
```

One thing to note here, is that genie uses the information provided to determine type.  In this example, ```min``` and ```max``` indicate that the resulting value should be numeric and reacts accordingly.

## More Complicated Example

Most real-world examples are a little more complicated.  Here is one such example.  This example generates a set of customer records with simulated orders containing random number of products for each order.


```
genie = require('../genie')
_ = require('underscore')

template = 
  name: 
    pattern: 'companyName'
  address1: 
    pattern: 'streetAddress'
  city: 
    pattern: 'city'
  state: 
    pattern: 'usStateAbbr'
  zip: 
    pattern: 'zipCode'
  employees: 
    min: 12
    max: 150
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
        max: 4
        template:
          itemNbr:
            format: 'I-#####'
          description:
            pattern: 'sentence'
          unitPrice:
            min: 2.50
            max: 15
            decimal: 2
          quantity:
            min: 1
            max: 100
          extendedPrice: ()->
            Math.round((this.unitPrice * this.quantity)*100)/100                  
      orderTotal: ()->
        total = _.reduce this.products, (memo, line) -> 
          memo + line.extendedPrice 
        , 0

customer = genie(template)

```

This results in a very rich data structure as shown below

```
{
  "name": "Rowe, Ortiz and Balistreri",
  "address1": "0738 Bartholome Road",
  "city": "Bergeville",
  "state": "UT",
  "zip": "64187",
  "employees": 105,
  "orders": [
    {
      "orderNbr": "3628099",
      "orderDate": "2013-04-08T18:58:08.537Z",
      "products": [
        {
          "itemNbr": "I-96613",
          "description": "sunt neque in expedita",
          "unitPrice": 8.07,
          "quantity": 73,
          "extendedPrice": 589.11
        },
        {
          "itemNbr": "I-62625",
          "description": "dignissimos officia est tempora dolores quia vero beatae",
          "unitPrice": 2.99,
          "quantity": 74,
          "extendedPrice": 221.26
        },
        {
          "itemNbr": "I-82971",
          "description": "quisquam odio maxime possimus unde",
          "unitPrice": 13.62,
          "quantity": 14,
          "extendedPrice": 190.68
        },
        {
          "itemNbr": "I-84714",
          "description": "ipsa dolores facere optio omnis magni",
          "unitPrice": 9.99,
          "quantity": 66,
          "extendedPrice": 659.34
        }
      ],
      "orderTotal": 3782.14
    },
    {
      "orderNbr": "2130755",
      "orderDate": "2013-04-06T18:58:08.540Z",
      "products": [
        {
          "itemNbr": "I-90946",
          "description": "nemo in molestias aut sunt repellendus debitis necessitatibus quia",
          "unitPrice": 2.69,
          "quantity": 74,
          "extendedPrice": 199.06
        },
        {
          "itemNbr": "I-56240",
          "description": "hic sit aut quis vitae error aliquam molestiae",
          "unitPrice": 14.93,
          "quantity": 52,
          "extendedPrice": 776.36
        }
      ],
      "orderTotal": 975.4200000000001
    }
  ]
}
```


## Template API

For each attribute in the template, or in nested templates, you can specify the rules used to generate the random data.

### Numbers

#### min

The minimum possible value

```
template = 
  quantity:
    min: 1
```

#### max

The maximum possible value

```
template = 
  quantity:
    min: 1
    max: 3
```

#### range

The range, in the form of a two element array, that define the minimum and maximum values possible for the value

```
template = 
  quantity:
    range: [2,5]
```

#### places

The number of possible decimal places

template = 
  quantity:
    min:1
    places: 2


### Dates

Dates are generated my giving a range, using ```minAge``` and ```maxAge```, which can be possitive and negative

#### min

The minimum possible date age is days.  Decimal values are OK.

```
template = 
  date:
    minAge: 1
```

#### max

The maximum possible date age is days.  Decimal values are OK.

```
template = 
  date:
    min: 0.1
    max: 3.5
```

#### format

Normally, dates are returned as actual date values, but frequently, you will want the string representation to store.  If a format is provided the date will be converted to a string using the provided format.

```
template = 
  date:
    min: 0.1
    max: 3.5
```


### Arrays

#### oneOf

Selects one randomly from the provided options.

```
template = 
  size:
    oneOf: [
      "Small", 
      "Medium", 
      "Large"
    ]
```

#### weightedSample

Simmilar to oneOf, but allows you to provide a relative weight to each of the values.  For example, if you sell twice as many larges as any other size, the following example might apply

```
template = 
  size:
    weightedSample: [
      [10, "Small"], 
      [20, "Medium"], 
      [30, "Large"]
    ]
```

Note that the weights are relative and do not need to add to a specific value, such as 1 or 100.


#### randomInRange

Gives a random integer within the specified range

```
template = 
  height:
    randomInRange: 42, 85
```



### Functions

Occasionally, you may need to execute a function to return a value.  While any function can be called, usually, this is really handy when you want date values within the object to tally properly.  See the more complicated example above.  Note:  it is important to remember that attributes are processed in order, so the function attributes should be defined after the informative attributes in the template.  Note:  The root object always refers to the top level object where `this` is always in the context of the current object.

```
template = 
  ref:
    min: 1
    max: 5
  target: (genie, rootObject)->
    this.ref + 1
```

### Patterns

In addition to the above, you can supply a named pattern to be applied. the following patterns are supported.

```
firstName
lastName
fullName
zipCode
zipCode5
zipCode9
city
streetName
streetAddress
secondaryAddress
brState
brStateAbbr
ukCounty
ukCountry
usState
usStateAbbr
latitude
longitude
phoneNumber
email
userName
domainName
domainWord
ipAddress
companyName
companySuffix
sentence
paragraph
```



