import socket
import random
import time
from itertools import cycle

HOST = "localhost"  # Replace with the actual server hostname if needed
PORT = 3000  # Replace with the desired port

# Create a socket object
# sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# try:
#     sock.connect((HOST, PORT))
# except ConnectionRefusedError:
#     print("Server not found. Please ensure it's listening on the specified port.")
#     exit(1)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as soc:
    soc.bind((HOST, PORT))
    soc.listen()
    conn, addr = soc.accept()
    print(conn, addr)
    with conn:
        words = ["apple", "banana", "orange", "grape", "mango"]
        words_cycle = cycle(words)
        for _ in range(10):  # Send 10 random words (adjust as needed)
            # word = next(words_cycle)
            word = random.choice(words)

            # Encode word as bytes before sending
            data = word.encode("utf-8")
            print(word)
            # Send data to the server
            conn.sendall(data)

            # Simulate processing time (adjust as needed)
            time.sleep(1)

        print("Finished sending random words.")


