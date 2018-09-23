 ntp_pool = {"120.25.108.11","202.112.31.197", "202.112.29.82", "182.92.12.11", "203.107.6.88","120.25.115.20"}
 sntp.sync(ntp_pool, nil, nil, 1)
 door_ctrl = 3
 gpio.mode(door_ctrl,  gpio.OUTPUT, gpio.PULLUP)
 gpio.write(door_ctrl, gpio.LOW)
 intpin = 5
 gpio.mode(intpin, gpio.INT)


 dofile("i2c_init.lua")
 dofile("door.lua")
-- dofile("int.lua")
  tmr.softwd(300)
  tmr.create():alarm(250000, tmr.ALARM_AUTO, function()
     tmr.softwd(300)
     print("reset sfwg")
  end)
