## grpc client and server in nodejs
command to run this project after cloning 
npm install


commads used to create the project from scratch 
npm init -y
npm install @grpc/grpc-js @grpc/proto-loader yargs


## Running the gRPC Server

To start the gRPC server, run the following command in a terminal inside this folder:

```bash
node server.js
```

This will start the server on the default port (`9999`).

#### Specifying a Custom Port

If you want to run the server on a different port, you can specify it using the `--port` argument:

```bash
node server.js --port 50051
```

## Running the gRPC Client

To send requests to the server, open another terminal (or use a different machine) and run the client:

#### Basic Usage

You need to specify the language when running the client. The supported languages are:

- `fr` for French
- `en` for English
- `ar` for Arabic

Example usage:

```bash
node client.js fr
```

This will send a request in French and receive a response from the server running on `127.0.0.1:9999`.

#### Specify a Custom IP Address and Port

By default, the client connects to `localhost` on port `9999`. You can specify a custom IP address and/or port using the `--ip` and `--port` arguments:

```bash
node client.js fr --ip 127.0.0.1 --port 50051
```

This will connect to the server running at IP address `127.0.0.1` on port `50051`.

#### Random Language Testing

To send requests every second with a random language, use the `--random-test` argument:

```bash
node client.js --random-test
```

This will continuously send random requests in French, English, or Arabic to the server every second.

You can also use the `--ip` and `--port` arguments with the `--random-test` option:

```bash
node client.js --random-test --ip 127.0.0.1 --port 50051
```