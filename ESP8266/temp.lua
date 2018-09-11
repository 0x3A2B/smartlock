id  = 0
sda = 5
scl = 6

-- initialize i2c, set pin1 as sda, set pin2 as scl
i2c.setup(id, sda, scl, i2c.SLOW)
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
    --sck:send(9999, "172.16.2.156", encoder.toHex(f))
    print(encoder.toHex(f))

   tmr.create():alarm(100, tmr.ALARM_SINGLE, function()
      i2c.start(id)
      i2c.address(id, dev_addr, i2c.RECEIVER)
      c = i2c.read(id, len+2)
      i2c.stop(id)
      --sck:send(9999, "172.16.2.156", encoder.toHex(c))
      print(encoder.toHex(c))
   end)
end

--pn532_send(0x24,encoder.fromHex("0000FF05FBD4140114000300"), 8)
function pn532_send2(dev_addr,data, len)

    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, data) 
    i2c.stop(id)

end