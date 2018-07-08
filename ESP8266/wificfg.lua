wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="905"
station_cfg.pwd="905509905"
station_cfg.save=true
wifi.sta.config(station_cfg)