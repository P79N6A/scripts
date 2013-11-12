
fs = require "fs"
querystring = require "querystring"

# 用于保存数据的变量.
browsers = {}
msgs = {}
errorCount = 0

# 读数据.
data = fs.readFileSync "./jserror.cashier.log.2", "utf-8"
data = data.split("\n")

# 遍历数据.
for item in data
  continue if item == ""

  # 第一层解析，解析系统数据.
  [a, b, c, d, e, f, g] = item.split(" ")
  e = e.replace "?url=", ""
  try
    e = decodeURIComponent e
  catch e
    errorCount++
  
  # 第二层解析，解析打点时通过 url 记录的数据.
  [e1, e2] = e.split "&profile=jserror"
  [url, os, browser, h, params] = e1.split "|"
  params = querystring.parse e2
  {msg, file} = params
  
  # console.log msg, url, browser

  # 保存数据.
  browsers[browser] or= 0
  browsers[browser]++

  msgs[msg] or= 0
  msgs[msg]++

#########################
# 输出.
console.log msgs
console.log browsers
console.log errorCount

# TODO:
# 1. 输出时进行下排序.


