local ip='127.0.0.1'
local port=1234

local ls=require "lsocket"


print("bind begin")
local serverAcceptSocket,error=ls.bind(ip,port,10)
if not serverAcceptSocket then
	print("bind error:" .. error)
	os.exit(1)
end
print("bind success")

local sockets={serverAcceptSocket}
local socketinfo={}

function add_socket( varSocket,varIp,varPort )
	sockets[#sockets+1]=varSocket --add to last one
	socketinfo[varSocket]=varIp .. ":" .. varPort
end

function remove_socket(varSocket)
	for i,v in ipairs(sockets) do
		if v==varSocket then
			table.remove(sockets,i)
			socketinfo[varSocket]=nil
			return
		end
	end
end

function string.split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end
	
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

repeat
	local ready=ls.select(sockets)
	for _,tmpSocket in ipairs(ready) do

		-- 如果当前工作socket是AcceptSocket，那么说明有新的客户端连接。
		--如果是别的socket，那么说明客户端发包过来了。
		if(tmpSocket==serverAcceptSocket) then
			local s1,ip,port = tmpSocket:accept()
			print("Client From:" .. ip .. ":" .. port)
			add_socket(s1,ip,port)
		else
			local info=socketinfo[tmpSocket]
			local str,err=tmpSocket:recv()
			if str~=nil then
				str=string.gsub(str,"\n$","")

				print(info .. " c->s:".. str)

				local strArr=string.split(str,"#")
	
				print("Account:"..strArr[1])
				print("Password:"..strArr[2])

				if strArr[1]=="captain" and strArr[2]=="123456" then

					tmpSocket:send("Login Success!\n")
				else
					tmpSocket:send("Account or Password Error!\n")
				end
			else
				if err==nil then
					print ("Client Disconnect:" .. info)
					tmpSocket:close()
					remove_socket(tmpSocket)
				else
					print("error:" .. error)
				end
			end
		end

	end


until false