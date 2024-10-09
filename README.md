# gRPC HelloWorld Multi-Language Client-Server Project

This project illustrates how gRPC can be used to establish client-server connections across different programming languages. It demonstrates the versatility of gRPC by implementing communication in various environments, each showcasing how to set up and use the gRPC framework effectively.

## Implemented Languages

- [Node.js](nodeJS/README.md): A gRPC implementation using Node.js, showcasing server and client interactions.
- [Python](python/README.md): A gRPC implementation in Python, demonstrating how to create and connect clients and servers.
- [Flutter (Dart)](mobileapp/README.md): A mobile application implementation using Flutter and Dart for gRPC communication.

**Important Note:** The Flutter implementation does not currently support the `SayHelloManyTimes` feature. Therefore, you cannot use the `--count` and `--intervalMS` options when using its client or server.

Each implementation contains its own README file with detailed instructions on how to initialize and use the gRPC setup for that specific language.
