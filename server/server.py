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
    print("SELECT * FROM Persons WHERE id = \'%s\' " % (id.decode('ascii')))
    c = cursor.execute("SELECT * FROM Persons WHERE id =\'%s\' " % (id.decode('ascii')))
    data = c.fetchone()
    if data == None:
        return False
    else:
        return data

ip_addr = get_host_ip()
print("Here is ", ip_addr)
BUFSIZE = 1024
ip_port = (ip_addr, 9999)
server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
server.bind(ip_port)

try:
    while True:
        data,client_addr = server.recvfrom(BUFSIZE)
        print(client_addr,'received:', data)
        if data == b'Out':
            cursor.execute('''INSERT INTO out (
            date, time
            )
            VALUES(DATE(), TIME()
            )''')
        else:
            id = data[4:12]
            name = findid(id)
            if name != False:
                timedate = get_time()
                server.sendto('Open'.encode('ascii'), client_addr)

                cursor.execute('''INSERT INTO history (
                id, code, name, in_date, in_time                      
                ) 
                VALUES( \'%s\', %d, \'%s\', DATE(), TIME()
                )'''   % (name[0], name[1], name[2]))
    server.close()
    cursor.close()
    people.commit()
except (Exception) as e:
    print(repr(e))
    server.close()
    cursor.close()
    people.commit()
    exit()
