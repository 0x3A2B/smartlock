print("Start door ctrl")
-- creat cinnection
sck = net.createUDPSocket()

-- call back
sck:on("sent", function(s)
    print("sent")
end)



-- user defined function: read from reg_addr content of dev_addr
function pn532_send(dev_addr,data, len)

    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, data) 
    i2c.stop(id)
    
    -- get ack
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    f = i2c.read(id, 8)
    i2c.stop(id)
    -- print(encoder.toHex(f))

   tmr.create():alarm(100, tmr.ALARM_SINGLE, function()
      i2c.start(id)
      i2c.address(id, dev_addr, i2c.RECEIVER)
      c = i2c.read(id, len+2)
      i2c.stop(id)
   end)
   -- print(encoder.toHex(c))
   if(c ~= nil) then
      return encoder.toHex(c)
   else
      return "80808080808080808080808080808080808080"
   end
end
function get_id()
   c = pn532_send(0x24, encoder.fromHex("0000FF04FCD44A0200E000"), 20)
   return string.sub(c, 29 , 36)
end

sendid = function(T)
   c = get_id()
   if(c ~= "80808080") then
      -- print(c)
      -- do something
      -- open the door
      sck:send(9999, "172.16.2.156", "ID*#" .. c .. "#*")
   end
   scancard:start()
end

-- init pn532
pn532_send(0x24,encoder.fromHex("0000FF05FBD4140114000300"), 8)

scancard = tmr.create()
scancard:register(200, tmr.ALARM_SEMI, sendid)
scancard:start()
