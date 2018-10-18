import sqlite3
import argparse
import time
import sys
people = sqlite3.connect('905people.db')
print ("Opened database successfully")
cursor = people.cursor()

def get_time():
    return time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) 


def findid(id):
    c = cursor.execute("SELECT * FROM Persons WHERE id =\'%s\' " % (id))
    data = c.fetchone()
    if data == None:
        return False
    else:
        return data


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", help="card's Id")
    parser.add_argument("-n", help="student's Name")
    parser.add_argument("-c", help="student's Code", type=int)
    args = parser.parse_args()
    id =  args.i
    name = args.n
    code = args.c

    print(id)
    print(code)
    print(name)
    if findid(id):
        print("Person exist")
    else:
        cursor.execute('''INSERT INTO Persons (
        id, name, code, department, insert_data, insert_time
        ) 
        VALUES(\'%s\', \'%s\', %d, \'%s\', DATE(), TIME()	
        )''' %(id, name, code, dep))
        people.commit()
    cursor.close()

if __name__ == "__main__":
    sys.exit(main())
