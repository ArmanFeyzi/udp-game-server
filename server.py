import socket
import time
import logging


def fake_server():
    logging.basicConfig(filename='out.log',
                        filemode='a',
                        format='%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s',
                        datefmt='%H:%M:%S',
                        level=logging.DEBUG)

    # Create a UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Bind the socket to a specific port
    server_address = ('0.0.0.0', 7778)
    sock.bind(server_address)

    logging.info("Server is ready... ")
    print("Server is ready... ")

    # Set timeout for the server
    timeout = time.time() + 600  # 10 minutes from now

    # Receive and print incoming messages
    while time.time() < timeout:
        data, address = sock.recvfrom(4096)
        log = f'Received {len(data)} bytes from {address}: {data}'
        print(log)
        logging.info(log)

    # Close the socket
    sock.close()


if __name__ == '__main__':
    fake_server()
