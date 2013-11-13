# encode: utf-8

require "mechanize"
require "json"

# Set username and password.
@username = ""
@password = ""

agent = Mechanize.new

# Login.
page              = agent.get "https://login.taobao.com/member/login.jhtml"
form              = page.form_with :id => "J_StaticForm"
form.TPL_username = @username
form.TPL_password = @password
agent.submit(form)

# Get token.
page  = agent.get "http://vip.taobao.com/vip_home.htm"
token = page.search("input[name=_tb_token_]")[0].attr("value")

# Get coins.
page = agent.get "http://vip.taobao.com/home/grant_everyday_coin.htm?_tb_token_=#{token}"

# Logger.
data = JSON.parse page.body
if data["isTake"] == "false"
  p "#{@username} 领取淘金币 #{data["coinNew"] - data["coinOld"]} 个"
else
  p "已领取，不能重复领取"
end
