 ntp_pool = {"120.25.108.11","202.112.31.197", "202.112.29.82", "182.92.12.11", "203.107.6.88","120.25.115.20"}
 sntp.sync(ntp_pool, nil, nil, 1)
 dofile("i2c_init.lua")
 dofile("door.lua")
