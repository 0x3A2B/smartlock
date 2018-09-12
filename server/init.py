import sqlite3
import argparse
import time
import sys
people = sqlite3.connect('905people.db')
print ("Opened database successfully")
cursor = people.cursor()
cursor.execute('''create table persons (
id           CHAR(8),
code         INT(16),
name         CHAR(50),
insert_data  DATE,
insert_time  TIME，
department   CHAR(50)                  )''')
cursor.execute('''create table history (
id           CHAR(8),
code         INT(16),
name         CHAR(50),
in_date      DATE,
in_time      TIME                      )''')
cursor.execute('''create table out (
date      DATE,
time      TIME                         )''')

people.commit()
cursor.close()
