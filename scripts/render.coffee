# Contrib.
console.time('require')
nodejsx = require 'coffee-react/register'
React = require 'react'
Test = require './test'
Index = require '../app/view/index'
data = require '../app/data'
console.timeEnd('require')

console.time('el')
el = React.createElement Index, {data: data}
console.timeEnd('el')

console.time('render')
str = React.renderToString el
console.timeEnd('render')

console.log str.length
