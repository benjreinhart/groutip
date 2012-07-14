{ print }  = require 'util'
{ spawn }  = require 'child_process'

Path = require 'path'
fs = require 'fs'

task 'createSymlink', 'create symlink between demo js and CS ouput in `./`', ->
  fs.symlink Path.join(__dirname, 'groutip.js'), Path.join(__dirname, 'demo/js/groutip.js')

task 'watch', 'Build ./groutip.js form ./src/groutip.coffee', ->
  coffee = spawn 'coffee', ['-w', '-c', '-o', '.', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()