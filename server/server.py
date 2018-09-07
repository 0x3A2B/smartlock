import socket

def get_host_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('1.1.1.1', 80))
        ip = s.getsockname()[0]
    finally:
        s.close()
    return ip

ip_addr = get_host_ip()
print("Here is ", ip_addr)
BUFSIZE = 1024
ip_port = (ip_addr, 9999)
server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
server.bind(ip_port)
while True:
    data,client_addr = server.recvfrom(BUFSIZE)
    print(client_addr,'received:', data)
server.close()
