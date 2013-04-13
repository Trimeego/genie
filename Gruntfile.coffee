
'use strict';

module.exports = (grunt)->

  grunt.initConfig
    nodeunit: 
      tests: ['test/*_test.js'],

    coffee:
      genie:
        files: [
          expand: true
          src: "genie.coffee"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          src: "test/**/*.coffee"
          ext: ".spec.js"
        ]

      examples:
        files: [
          expand: true
          src: "examples/**/*.coffee"
          ext: ".js"
        ]

  grunt.loadNpmTasks('grunt-contrib-nodeunit')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('test', ['clean', 'coffee', 'nodeunit'])

