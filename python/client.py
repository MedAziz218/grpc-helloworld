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
        try:
            response = stub.SayHello(request)
            print("Réponse du serveur: " + response.message)
        except grpc.RpcError as e:
            print(f"Erreur lors de l'appel RPC: {e.details()}")

def run_random_test(ip, port):
    languages = ['fr', 'en', 'ar']
    with grpc.insecure_channel(f'{ip}:{port}') as channel:
        stub = helloworld_pb2_grpc.HelloWorldServiceStub(channel)
        while True:
            language = random.choice(languages)
            request = helloworld_pb2.HelloRequest(language=language)
            try:
                response = stub.SayHello(request)
                print(f"Langue choisie: {language} - Réponse du serveur: {response.message}")
            except grpc.RpcError as e:
                print(f"Erreur lors de l'appel RPC: {e.details()}")
            time.sleep(1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Client gRPC pour dire HelloWorld dans différentes langues")
    parser.add_argument('language', type=str, nargs='?', help="Langue à utiliser pour dire 'Hello World' (fr, en, ar)")
    parser.add_argument('--ip', type=str, default='localhost', help="Adresse IP du serveur gRPC (par défaut: localhost)")
    parser.add_argument('--port', type=int, default=9999, help="Port du serveur gRPC (par défaut: 9999)")
    parser.add_argument('--random-test', action='store_true', help="Envoyer des requêtes avec des langues choisies aléatoirement chaque seconde")

    args = parser.parse_args()

    if args.random_test:
        run_random_test(args.ip, args.port)
    else:
        if args.language:
            run(args.language, args.ip, args.port)
        else:
            print("Veuillez spécifier une langue ou utiliser --random-test.")
