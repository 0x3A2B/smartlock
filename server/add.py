import sqlite3
import argparse
import time
import sys
people = sqlite3.connect('905people.db')
print ("Opened database successfully")
cursor = people.cursor()

def get_time():
    return time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) 

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", help="card's Id")
    parser.add_argument("-n", help="student's Name")
    parser.add_argument("-c", help="student's code", type=int)
    args = parser.parse_args()
    id =  args.i
    name = args.n
    code = args.c
    insert_data = get_time()
    try:
        int(args.i , 16)
    except:
        print("card'id wrong")
        cursor.close()
        exit()
    if(len(id) != 8):
        print("ID length error")
        cursor.close()
        exit()
    print(id)
    print(code)
    print(name)
    try:
        cursor.execute('''CREATE TABLE %s(
        time  TIME, 
        date  DATE
        )''' %(name) )
    except:
        print("table error")
        exit()
    cursor.execute('''INSERT INTO Persons (
    id, name, code, insert_data
    ) 
    VALUES(\'%s\', \'%s\', %d, \'%s\'
    )''' %(id, name, code, insert_data))
    people.commit()
    cursor.close()

if __name__ == "__main__":
    sys.exit(main())