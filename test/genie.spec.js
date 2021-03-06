(function() {
  var expect, genie, moment, _;

  expect = require("expect.js");

  genie = require("../genie");

  moment = require("moment");

  _ = require("underscore");

  describe("Genie", function() {
    describe("Numbers", function() {
      it("uses the min option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            quantity: {
              min: 1
            }
          });
          expect(obj.quantity).to.be.ok();
          _results.push(expect(obj.quantity).to.be.within(1, 1000000));
        }
        return _results;
      });
      it("uses the max option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            quantity: {
              min: 1,
              max: 3
            }
          });
          expect(obj.quantity).to.be.ok();
          _results.push(expect(obj.quantity).to.be.within(1, 3));
        }
        return _results;
      });
      it("uses the range option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            quantity: {
              range: [2, 5]
            }
          });
          expect(obj.quantity).to.be.ok();
          _results.push(expect(obj.quantity).to.be.within(2, 5));
        }
        return _results;
      });
      it("uses the places option", function() {
        var hasplaces, obj, x, _i;

        hasplaces = false;
        for (x = _i = 1; _i <= 10; x = ++_i) {
          obj = genie({
            quantity: {
              min: 1,
              places: 2
            }
          });
          if (obj.quantity % 1 > 0) {
            hasplaces = true;
          }
        }
        return expect(hasplaces).to.be.ok();
      });
      return it("uses the round option", function() {
        var hasplaces, obj, rounded, x, _i;

        hasplaces = false;
        for (x = _i = 1; _i <= 10; x = ++_i) {
          obj = genie({
            quantity: {
              min: 1000000,
              min: 10000000,
              round: 1000000
            }
          });
          if (obj.quantity % 1000000 === 0) {
            rounded = true;
          }
        }
        return expect(rounded).to.be.ok();
      });
    });
    describe("Dates", function() {
      it("uses the age option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            dt: {
              minAge: 1,
              maxAge: 5
            }
          });
          expect(obj.dt).to.be.ok();
          _results.push(expect(obj.dt.getTime()).to.be.within(moment().subtract('days', 5), moment().subtract('days', 1)));
        }
        return _results;
      });
      return it("uses the age option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            dt: {
              minAge: 1,
              maxAge: 5,
              format: 'MM/DD/YYYY'
            }
          });
          expect(obj.dt).to.be.ok();
          _results.push(expect(obj.dt).to.match(/\d{2}\/\d{2}\/\d{4}/));
        }
        return _results;
      });
    });
    describe("Patterns", function() {
      it("uses the firstName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'firstName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the lastName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'lastName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the fullName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'fullName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the zipCode option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'zipCode'
            }
          });
          expect(obj.target).to.be.ok();
          _results.push(expect(obj.target).to.match(/\d{5}(\-\d{4})?/));
        }
        return _results;
      });
      it("uses the zipCode5 option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'zipCode5'
            }
          });
          expect(obj.target).to.be.ok();
          _results.push(expect(obj.target).to.match(/\d{5}/));
        }
        return _results;
      });
      it("uses the zipCode9 option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'zipCode9'
            }
          });
          expect(obj.target).to.be.ok();
          _results.push(expect(obj.target).to.match(/\d{5}\-\d{4}/));
        }
        return _results;
      });
      it("uses the city option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'city'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the streetName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'streetName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the streetAddress option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'streetAddress'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the secondaryAddress option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'secondaryAddress'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the brState option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'brState'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the brStateAbbr option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'brStateAbbr'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the ukCounty option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'ukCounty'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the ukCountry option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'ukCountry'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the usState option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'usState'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the usStateAbbr option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'usStateAbbr'
            }
          });
          expect(obj.target).to.be.ok();
          _results.push(expect(obj.target).to.match(/\w{2}/));
        }
        return _results;
      });
      it("uses the latitude option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'latitude'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the longitude option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'longitude'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the phoneNumber option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'phoneNumber'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the email option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'email'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the userName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'userName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the domainName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'domainName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the domainWord option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'domainWord'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the ipAddress option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'ipAddress'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the companyName option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'companyName'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the companySuffix option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'companySuffix'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      it("uses the sentence option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'sentence'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
      return it("uses the paragraph option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            target: {
              pattern: 'paragraph'
            }
          });
          _results.push(expect(obj.target).to.be.ok());
        }
        return _results;
      });
    });
    describe("Arrays", function() {
      it("uses the oneOf option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            one: {
              oneOf: [1, 2, 3]
            }
          });
          expect(obj.one).to.be.ok();
          _results.push(expect(obj.one).to.be.within(1, 3));
        }
        return _results;
      });
      it("uses the someOf option", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            one: {
              someOf: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
            }
          });
          expect(obj.one).to.be.ok();
          _results.push(expect(obj.one.length).to.be.within(1, 10));
        }
        return _results;
      });
      return it("uses the weightedSample option", function() {
        var obj, results, x, _i;

        results = {
          small: 0,
          medium: 0,
          large: 0
        };
        for (x = _i = 1; _i <= 1000; x = ++_i) {
          obj = genie({
            one: {
              weightedSample: [[10, "small"], [30, "medium"], [60, "large"]]
            }
          });
          expect(obj.one).to.be.ok();
          results[obj.one] += 1;
        }
        expect(results.small).to.be.within(50, 150);
        expect(results.medium).to.be.within(250, 350);
        return expect(results.large).to.be.within(550, 650);
      });
    });
    describe("Exixts", function() {
      return it("honors the exists value", function() {
        var obj, x, _i, _results;

        _results = [];
        for (x = _i = 1; _i <= 20; x = ++_i) {
          obj = genie({
            quantity: {
              exists: function() {
                return false;
              },
              min: 1
            }
          });
          _results.push(expect(obj.quantity).to.not.be.ok());
        }
        return _results;
      });
    });
    describe("Functions", function() {
      it("uses an arbitrary function if passed", function() {
        var obj;

        obj = genie({
          target: function() {
            return 5;
          }
        });
        return expect(obj.target).to.be(5);
      });
      it("applies correct function context", function() {
        var obj;

        obj = genie({
          ref: {
            min: 1,
            max: 5
          },
          target: function() {
            return this.ref + 1;
          }
        });
        return expect(obj.target).to.be(obj.ref + 1);
      });
      return it("passes genie object into function with helpers", function() {
        var obj;

        return obj = genie({
          ref: {
            min: 1,
            max: 5
          },
          target: function(genie) {
            expect(genie).to.not.be(null);
            expect(genie.oneOf).to.not.be(null);
            expect(genie.format).to.not.be(null);
            expect(genie.weightedSample).to.not.be(null);
            return expect(genie.pattern).to.not.be(null);
          }
        });
      });
    });
    return describe("Nested Nodes", function() {
      return it("generates child nodes or arbitrary depth if template nodes are specified", function() {
        var customer;

        customer = genie({
          name: {
            pattern: 'fullName'
          },
          orders: {
            min: 1,
            max: 2,
            template: {
              orderNbr: {
                format: '#######'
              },
              orderDate: {
                maxAge: 8,
                minAge: 4
              },
              products: {
                min: 1,
                max: 10,
                template: {
                  itemNbr: {
                    format: 'I-#####'
                  },
                  description: {
                    pattern: 'sentence'
                  },
                  unitPrice: {
                    min: 2.50,
                    max: 15,
                    places: 2
                  },
                  quantity: {
                    min: 1,
                    max: 100
                  },
                  extendedPrice: function() {
                    return Math.round((this.unitPrice * this.quantity) * 100) / 100;
                  }
                }
              },
              orderTotal: function() {
                var total;

                return total = _.reduce(this.products, function(memo, line) {
                  return memo + line.extendedPrice;
                }, 0);
              }
            }
          }
        });
        expect(customer.orders.length).to.be.greaterThan(0);
        return expect(customer.orders[0].products.length).to.be.greaterThan(0);
      });
    });
  });

}).call(this);
