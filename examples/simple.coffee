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

console.log(customer)