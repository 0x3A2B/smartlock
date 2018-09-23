gpio.mode(intpin, gpio.INT)
gpio.trig(intpin, "up",function(level, pulse2)
    gpio.serout(door_ctrl,gpio.HIGH,{9000,1000})
    end
)
