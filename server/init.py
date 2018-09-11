import sqlite3
import argparse
import time
import sys
people = sqlite3.connect('905people.db')
print ("Opened database successfully")
cursor = people.cursor()
cursor.execute('''create table persons (
id          char(8),
code        int(16),
name        char(50),
insert_data DATETIME,
timem TIMESTAMP)''')