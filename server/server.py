import socket
import sqlite3
import argparse
import time
import sys
people = sqlite3.connect('905people.db')
print("Opened database successfully")
cursor = people.cursor()

def get_host_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('1.1.1.1', 80))
        ip = s.getsockname()[0]
    finally:
        s.close()
    return ip

def get_time():
    return time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) 

def findid(id):
    c = cursor.execute('''SELECT * FROM Persons WHERE id=\'%s\' ''' % (id))
    data = c.fetchone()
    if data == None:
        return False
    else:
        return data[2]

ip_addr = get_host_ip()
print("Here is ", ip_addr)
BUFSIZE = 1024
ip_port = (ip_addr, 9999)
server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
server.bind(ip_port)


while True:
    data,client_addr = server.recvfrom(BUFSIZE)
    print(client_addr,'received:', data)
    id = data[4:12]
    with findid(id) as name:
        if name :
            timedate = get_time()
            server.sendto('Open', (client_addr, 9999))
            cursor.execute('''INSERT INTO %s (
            time , date
            ) 
            VALUES(\'%s\', \'%s\'
            )''' % (name, timedate[0:10], timedate[11:]))
    people.commit()
server.close()
cursor.close()
