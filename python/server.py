# server.py
import argparse
import grpc
import helloworld_pb2
import helloworld_pb2_grpc
from concurrent import futures

class HelloWorldServiceServicer(helloworld_pb2_grpc.HelloWorldServiceServicer):
    request_counter = 0
    def SayHello(self, request, context):
        language = request.language.lower()
        self.request_counter += 1
        i = self.request_counter
        print(f"{i}>>> received request for language: {language}")
        if language == "fr":
            message = "python dit Bonjour le monde "
        elif language == "en":
            message = "python say Hello World"
        elif language == "ar":
            message = "بايثون يقول مرحبا بالعالم "
        else:
            message = "Language not supported"

        return helloworld_pb2.HelloResponse(message=message)

def serve(port):
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    helloworld_pb2_grpc.add_HelloWorldServiceServicer_to_server(HelloWorldServiceServicer(), server)
    server.add_insecure_port(f'[::]:{port}')
    server.start()
    print(f"'Python' gRPC Server is running on port {port}")
    server.wait_for_termination()

def main():
    parser = argparse.ArgumentParser(description='gRPC Server')
    parser.add_argument(
        '--port', '-p',
        type=int,
        default='9999',
        help='Port on which the gRPC server will run (default: 9999)'
    )
    args = parser.parse_args()
    serve(args.port)

if __name__ == '__main__':
    main()
