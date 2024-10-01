# gRPC HelloWorld Application

This project demonstrates a simple gRPC-based client-server application that sends "Hello World" messages in multiple languages. The server responds with a message in French, English, or Arabic based on the user's input.

## Prerequisites

- **Python 3.x**
- **gRPC and protobuf libraries** (install instructions below)

## Setting Up the Environment

### Step 1: Create a Virtual Environment

Create a virtual environment to isolate the project dependencies:

```bash
python -m venv grpcEnv
```

### Step 2: Activate the Virtual Environment

Activate the environment based on your operating system:

- **Windows**:
  ```bash
  .\grpcEnv\Scripts\activate
  ```
  
- **Linux / macOS**:
  ```bash
  source ./grpcEnv/bin/activate
  ```

### Step 3: Install Dependencies

Install the necessary packages using `pip`. You can either use the `requirements.txt` file or manually install the specific package versions.

- **Option 1:** Install from `requirements.txt`

    ```bash
    pip install -r requirements.txt
    ```

- **Option 2:** Manually Install Dependencies

    ```bash
    pip install grpcio==1.66.1 grpcio-tools==1.66.1 protobuf==5.27.2
    ```

### Step 4: Compile the Protobuf Files


To generate the Python protobuf and gRPC interfaces from the `.proto` file, run the following command:

```bash
python -m grpc_tools.protoc --python_out=. --grpc_python_out=. --proto_path=..\protos helloworld.proto
```

This command will generate the necessary Python code to interact with the `helloworld.proto` definitions.


## Running the gRPC Server

To start the gRPC server, run the following command in a terminal inside this folder:

```bash
python server.py
```

This will start the server on the default port (`9999`).

#### Specifying a Custom Port

If you want to run the server on a different port, you can specify it using the `--port` argument:

```bash
python server.py --port 50051
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
python client.py fr
```

This will send a request in French and receive a response from the server running on `127.0.0.1:9999`.

#### Specify a Custom IP Address and Port

By default, the client connects to `localhost` on port `9999`. You can specify a custom IP address and/or port using the `--ip` and `--port` arguments:

```bash
python client.py fr --ip 127.0.0.1 --port 50051
```

This will connect to the server running at IP address `127.0.0.1` on port `50051`.

#### Random Language Testing

To send requests every second with a random language, use the `--random-test` argument:

```bash
python client.py --random-test
```

This will continuously send random requests in French, English, or Arabic to the server every second.

You can also use the `--ip` and `--port` arguments with the `--random-test` option:

```bash
python client.py --random-test --ip 127.0.0.1 --port 50051
```

## Summary

This simple gRPC application demonstrates:

- A server that responds in multiple languages (French, English, Arabic)
- A client that can request a greeting in a specified language
- The ability to connect the client to any IP address and port
- The option to run randomized requests to the server


