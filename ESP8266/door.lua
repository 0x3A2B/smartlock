srv = net.createConnection(net.TCP, 0)
srv:on("receive", function(sck, c) sck:send("OK,GOTIT") print(c)end)
-- Wait for connection before sending.
srv:on("connection", function(sck, c)
  -- 'Connection: close' rather than 'Connection: keep-alive' to have server 
  -- initiate a close of the connection after final response (frees memory 
  -- earlier here), https://tools.ietf.org/html/rfc7230#section-6.6 
  sck:send("smartdoocconnect")
end)
srv:connect(9999,"172.16.2.223")
-- user defined function: read from reg_addr content of dev_addr
function pn532_send(dev_addr,data, len)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, data)
    --i2c.write(id, encoder.fromHex("0000FF04FCD44A0200E000")) 
    -- init and get ID
    --i2c.write(id, encoder.fromHex("0000FF03FDD414011700")) 
    --i2c.write(id, encoder.fromHex("0000FF04FCD44A0200E000")) 
    i2c.stop(id)
    --get ack
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    f = i2c.read(id, 8)
    i2c.stop(id)
    --print(encoder.toHex(f))

   tmr.create():alarm(100, tmr.ALARM_SINGLE, function()
      i2c.start(id)
      i2c.address(id, dev_addr, i2c.RECEIVER)
      c = i2c.read(id, len+2)
      i2c.stop(id)
   end)
   --print(encoder.toHex(c))
   if(c ~= nil) then
      return encoder.toHex(c)
   end
end
function get_id()
   c = pn532_send(0x24, encoder.fromHex("0000FF04FCD44A0200E000"), 20)
   return string.sub(c, 29 , 36)
end

sendid = function(T)
   c = get_id()
   if(c ~= "80808080") then
      --print(c)
      --do something
      -- open the door
      srv:send("ID*#" .. c .. "#*")
   end

   --- open the door


   
   scancard:start()
end

--init pn532
pn532_send(0x24,encoder.fromHex("0000FF05FBD4140114000300"), 8)

scancard = tmr.create()
scancard:register(200, tmr.ALARM_SEMI, sendid)
scancard:start()