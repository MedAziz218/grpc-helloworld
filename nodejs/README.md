## HelloWorld Application in NodeJS

This project demonstrates a simple gRPC-based client-server application that sends "Hello World" messages in multiple languages. The server responds with a message in French, English, or Arabic based on the user's input.

### Prerequisites

- **Node.js** (version 14.x or later)
- **npm** (Node package manager)



## Setting Up the Environment

**Install Dependencies**

Inside the nodeJS project directory, install the necessary packages using npm:

```bash
npm install
```

This command installs all required dependencies for the gRPC client-server application.

- **Optional:** 

    If you wish to recreate the project from scratch, here are the commands that were used to set it up initially. 

    **Note:** This step is optional and not required to run the existing project:

    ```bash
    npm init -y
    npm install @grpc/grpc-js @grpc/proto-loader yargs
    ```


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

**Check for Errors**: Ensure that your server code correctly handles the port argument and starts listening on the specified port.

## Running the gRPC Client

The client supports various options to control the number of responses, the delay between them, and how it connects to the server.

### Basic Usage

Specify the language when running the client. Supported languages are:

- `fr` for French
- `en` for English
- `ar` for Arabic

Example:

```bash
node client.js en
```

This sends a request in English to the server running on `127.0.0.1:9999`.

### Custom IP and Port

By default, the client connects to `localhost` on port `9999`. To use a custom IP and port:

```bash
node client.js fr --ip 127.0.0.1 --port 50051
```

**Check for Errors**: Make sure the client correctly establishes a connection to the server using the specified IP and port.

### Specify Number of Replies and Delay

The client can request multiple replies from the server using gRPC streams:

- `--count` (default: 1): Specifies how many replies to receive. If `count > 1`, the server will use gRPC streaming to send multiple responses.
- `--intervalMS` (default: 0): Sets the delay in milliseconds between each reply when `count > 1`.

Example:

```bash
node client.js en --count 5 --intervalMS 200 --port 9999 --ip 127.0.0.1
```

This requests 5 replies from the server with a 200 ms delay between each one.

### Random Language Testing

To send requests with a randomly chosen language every second:

```bash
node client.js --random-test
```

You can combine this with the `--count` and `--intervalMS` options to stream multiple replies:

```bash
node client.js --random-test --count 5 --intervalMS 200 --port 9999 --ip 127.0.0.1
```

This sends random requests every second, receiving 5 replies with a 200 ms delay between each.

**Check for Errors**: Verify that the client handles the random test option correctly and maintains the specified count and interval settings.

## Summary

This simple gRPC application demonstrates:

- A server that responds in multiple languages (French, English, Arabic)
- A client that can request a greeting in a specified language
- The ability to connect the client to any IP address and port
- The option to run randomized requests to the server

