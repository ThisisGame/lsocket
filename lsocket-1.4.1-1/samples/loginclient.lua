local ls=require "lsocket"

local serverip='127.0.0.1'
local serverport = 1234

local clientSocket,error = ls.connect(serverip,serverport)
if not clientSocket then
	print("connect loginserver error:"..error)
	os.exit(1)
end

--客户端也存在多个socket的情况，所以也要select操作?
ls.select(nil,{clientSocket})
local ok,error=clientSocket:status()
if not ok then
	print("error:" .. error)
	os.exit(1)
end


io.write("Account:")
account=io.read()
io.write("Password:")
password=io.read()
ok,error=clientSocket:send(account  .. "#" .. password)
if not ok then
	print("error:" .. error)
end

ls.select({clientSocket})
str,err=clientSocket:recv()
if str then
	print("s->c:" .. str)
else
	if err then
		print("recv error:"..err)
	else
		print("recv exit,server die")

	end
end