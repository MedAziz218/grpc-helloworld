# server.py
import argparse
import grpc
import helloworld_pb2
import helloworld_pb2_grpc
from concurrent import futures
from datetime import datetime
import time

def get_current_time():
    now = datetime.now()
    return now.strftime("%H:%M:%S:%f")[:-3]  # Strip last three digits to get ms precision

def get_greeting(language):
    if language == "fr":
        return "python dit Bonjour le monde "
    elif language == "en":
        return "python say Hello World"
    elif language == "ar":
        return "بايثون يقول مرحبا بالعالم  "
    else:
        return "Language not supported"


class HelloWorldServiceServicer(helloworld_pb2_grpc.HelloWorldServiceServicer):
    request_counter = 0

    def SayHello(self, request, context):
        language = request.language.lower()
        self.request_counter += 1
        i = self.request_counter
        print(f"{i}>>> received request for language: {language}")
        greeting = get_greeting(language)

        return helloworld_pb2.HelloResponse(message=greeting)

    def SayHelloManyTimes(self, request, context):
        language = request.language
        count = request.count
        intervalMS = request.intervalMS

        self.request_counter += 1
        i = self.request_counter
        print(
            f"{i}>>> received Stream request for {count} hellos in ({language}) with {intervalMS} ms in between ..."
        )

        greeting = get_greeting(language)

        # Stream responses with a delay in between
        for i in range(count):
            current_time = get_current_time()
            message = f"{greeting} {i + 1}"

            response = helloworld_pb2.HelloStreamResponse(
                message=message, time=current_time
            )

            yield response
            time.sleep(intervalMS / 1000)  # Delay of 1 second between responses


def serve(port):
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    helloworld_pb2_grpc.add_HelloWorldServiceServicer_to_server(
        HelloWorldServiceServicer(), server
    )
    server.add_insecure_port(f"[::]:{port}")
    server.start()
    print(f"'Python' gRPC Server is running on port {port}")
    server.wait_for_termination()


def main():
    parser = argparse.ArgumentParser(description="gRPC Server")
    parser.add_argument(
        "--port",
        "-p",
        type=int,
        default="9999",
        help="Port on which the gRPC server will run (default: 9999)",
    )
    args = parser.parse_args()
    serve(args.port)


if __name__ == "__main__":
    main()
