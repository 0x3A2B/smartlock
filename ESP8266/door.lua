srv = net.createConnection(net.TCP, 0)
srv:on("receive", function(sck, c) print(c) end)
-- Wait for connection before sending.
srv:on("connection", function(sck, c)
  -- 'Connection: close' rather than 'Connection: keep-alive' to have server 
  -- initiate a close of the connection after final response (frees memory 
  -- earlier here), https://tools.ietf.org/html/rfc7230#section-6.6 
  sck:send("GET /get HTTP/1.1\r\nHost: httpbin.org\r\nConnection: close\r\nAccept: */*\r\n\r\n")
end)
srv:connect(9999,"172.16.2.223")
-- user defined function: read from reg_addr content of dev_addr
function pn532_send(dev_addr,data)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, data)
    --i2c.write(id, encoder.fromHex("0000FF04FCD44A0200E000")) 
    -- init and get ID
    --i2c.write(id, encoder.fromHex("0000FF03FDD414011700")) 
    --i2c.write(id, encoder.fromHex("0000FF04FCD44A0200E000")) 
    i2c.stop(id)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    c = i2c.read(id, 25)
    i2c.stop(id)

    return encoder.toHex(c)
end
reg = pn532_send(0x24,encoder.fromHex("0000FF03FDD414011700"))
function get_id()
   c = pn532_send(0x24, encoder.fromHex("0000FF04FCD44A0200E000"))
   return string.sub(c, 29 , 36)
end

reg = get_id()
print(reg)
