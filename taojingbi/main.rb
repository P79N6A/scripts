# encode: utf-8

require "mechanize"
require "json"

# Your username and password.
@username = ""
@password = ""

agent = Mechanize.new
page = agent.get "http://vip.taobao.com/vip_home.htm"

# Login.
unless page.body.match(/get-coin J_GetCoin/)
  page = agent.get "https://login.taobao.com/member/login.jhtml"
  form = page.form_with :id => "J_StaticForm"
  form.TPL_username = @username
  form.TPL_password = @password
  agent.submit(form)
  
  page = agent.get "http://vip.taobao.com/vip_home.htm"
end

# Get coins.
_tb_token = page.search("input[name=_tb_token_]")[0].attr("value")
page = agent.get "http://vip.taobao.com/home/grant_everyday_coin.htm?_tb_token_=#{_tb_token}"
data = JSON.parse page.body
coins_count = data["coinNew"] - data["coinOld"]

# Logger.
if data["isTake"] == "false"
  p "#{@username} 领取淘金币 #{coins_count} 个"
else
  p "已领取，不能重复领取"
end
