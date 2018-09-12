intpin = 6
gpio.mode(intpin, gpio.INT)
gpio.trig(intpin, "up",function(level, pulse2)
    gpio.serout(5,gpio.HIGH,{9000,1000})
    end
)