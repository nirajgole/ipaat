import socket
import sys
from time import sleep
import os

# Ensure correct path separator for Windows
# filename = os.path.abspath("./RomeoJuliet.txt")
filename = "E:\\Gole_Niraj\\IPaat\ipaat\\SPARK\\assignments\\pyspark_streaming\\rj.txt"
# Or:

# filename = "..\\resources\\data\\insee\\nat2018.csv"

HOST = '127.0.0.1'  # Standard loopback interface address (localhost)
PORT = 3000        # Port to listen on

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    print(conn, addr)
    with conn:
        try:
            with open(filename, 'r') as f1:
                print('Connected by', addr)

                for line in f1:
                    sys.stdout.write(line)  # Print to server console for debugging
                    conn.sendall(line.encode('UTF-8'))
                    sleep(0.000001)
        except FileNotFoundError:
            print(f"Error: File not found: {filename}")
            conn.sendall(b"Error: File not found\n")




