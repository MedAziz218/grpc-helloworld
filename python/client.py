import grpc
import helloworld_pb2
import helloworld_pb2_grpc
import argparse
import random
import time

def run(language, ip, port):
    with grpc.insecure_channel(f'{ip}:{port}') as channel:
        stub = helloworld_pb2_grpc.HelloWorldServiceStub(channel)
        request = helloworld_pb2.HelloRequest(language=language)
        print(f"--> Sent gRPC request ({language})...")
        try:
            response = stub.SayHello(request)
            print(f"Response: {response.message}")
        except grpc.RpcError as e:
            print(f"Error: {e.details()}")

def run_random_test(ip, port):
    languages = ['fr', 'en', 'ar']
    with grpc.insecure_channel(f'{ip}:{port}') as channel:
        stub = helloworld_pb2_grpc.HelloWorldServiceStub(channel)
        while True:
            language = random.choice(languages)
            request = helloworld_pb2.HelloRequest(language=language)
            print(f"--> Sent gRPC request ({language})...")
            try:
                response = stub.SayHello(request)
                print(f"Response: {response.message}")
            except grpc.RpcError as e:
                print(f"Error: {e.details()}")
            time.sleep(1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="gRPC client to say HelloWorld in different languages")
    parser.add_argument('language', type=str, nargs='?', help="Language to use to say 'Hello World' (fr, en, ar)")
    parser.add_argument('--ip', type=str, default='localhost', help="IP address of the gRPC server (default: localhost)")
    parser.add_argument('--port', type=int, default=9999, help="Port of the gRPC server (default: 9999)")
    parser.add_argument('--random-test', action='store_true', help="Send requests with randomly chosen languages every second")

    args = parser.parse_args()

    if args.random_test:
        run_random_test(args.ip, args.port)
    else:
        if args.language:
            run(args.language, args.ip, args.port)
        else:
            print("Please specify a language or use --random-test.")
