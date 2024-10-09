import grpc
import helloworld_pb2
import helloworld_pb2_grpc
import argparse
import random
import time

languages = ["fr", "en", "ar"]


def getRandomLanguage():
    return random.choice(languages)

def callSayHello(language, stub: helloworld_pb2_grpc.HelloWorldServiceStub):
    request = helloworld_pb2.HelloRequest(language=language)
    print(f"--> Sent gRPC request ({language})...")
    try:
        response = stub.SayHello(request)
        print(f"Response: {response.message}")
    except grpc.RpcError as e:
        print(f"Error: {e.details()}")


def callSayHelloManyTimes(
    language,
    count,
    intervalMS,
    stub: helloworld_pb2_grpc.HelloWorldServiceStub,
    onEnd=None,
):
    request = helloworld_pb2.HelloStreamRequest(
        language=language, count=count, intervalMS=intervalMS
    )
    print(
        f"--> sent gRPC request {count} hellos in ({language}) with {intervalMS} ms in between ..."
    )

    try:
        response_stream = stub.SayHelloManyTimes(request)
        for response in response_stream:
            print(f"Response: [{response.time}] {response.message}")
        # Stream has ended if we exit the for loop
        print("Stream has ended.")
        if onEnd:
            onEnd()

    except grpc.RpcError as e:
        print(f"Error: {e.details()}")


def main():
    # parse arguments
    parser = argparse.ArgumentParser(
        description="gRPC client to say HelloWorld in different languages"
    )
    parser.add_argument(
        "language",
        type=str,
        nargs="?",
        help="Language to use to say 'Hello World' (fr, en, ar)",
    )
    parser.add_argument(
        "--ip",
        type=str,
        default="localhost",
        help="IP address of the gRPC server (default: localhost)",
    )
    parser.add_argument(
        "--port", type=int, default=9999, help="Port of the gRPC server (default: 9999)"
    )
    parser.add_argument(
        "--random-test",
        action="store_true",
        help="Send requests with randomly chosen languages every second",
    )
    parser.add_argument(
        "--count",
        type=int,
        default=1,
        help="Number of replies to request from the server (uses gRPC streams)",
    )
    parser.add_argument(
        "--intervalMS",
        type=int,
        default=1000,
        help="Delay in milliseconds between server stream responses (for count > 1)",
    )
    args = parser.parse_args()

    # destructure and validate arguments
    language = args.language
    count = args.count
    intervalMS = args.intervalMS
    ip = args.ip
    port = args.port
    random_test = args.random_test

    if not random_test and not language:
        print(
            "Error: Language argument is required. Please provide a language (fr, en, ar). (use --help for more information)"
        )
        exit(1)

    if count <= 0:
        print(
            "Error: --count argument must be greater than 0. (use --help for more information)"
        )
        exit(1)

    if count > 1 and intervalMS < 0:
        print(
            "Error: --intervalMS argument must be greater than or equal to 0. (use --help for more information)"
        )
        exit(1)

    # create grpc channel and run main function depending on arguments

    with grpc.insecure_channel(f"{ip}:{port}") as channel:
        stub = helloworld_pb2_grpc.HelloWorldServiceStub(channel)
        if count == 1:
            if random_test:
                while True:
                    callSayHello(getRandomLanguage(), stub)
                    time.sleep(1)
            else:
                callSayHello(language, stub)
        elif count > 1:
            if random_test:
                while True:

                    def randomCall():
                        time.sleep(1)
                        callSayHelloManyTimes(
                            getRandomLanguage(),
                            count,
                            intervalMS,
                            stub,
                            onEnd=randomCall,
                        )

                    callSayHelloManyTimes(
                        getRandomLanguage(), count, intervalMS, stub, onEnd=randomCall
                    )
                    time.sleep(1)
            else:
                callSayHelloManyTimes(language, count, intervalMS, stub)


if __name__ == "__main__":
    main()
