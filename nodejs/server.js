const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const yargs = require('yargs');

// Load command-line arguments using yargs
const argv = yargs
    .option('port', {
        alias: 'p',
        description: 'Port to run the gRPC server on',
        type: 'number',
        default: 9999
    })
    .help()
    .argv;

// Load the protobuf
const PROTO_PATH = "../protos/helloworld.proto";
const packageDefinition = protoLoader.loadSync(PROTO_PATH, {});
const helloWorldProto = grpc.loadPackageDefinition(packageDefinition).helloworld;

// Implement the sayHello RPC method
let request_counter = 0;
const sayHello = (call, callback) => {
    const { language } = call.request;
    request_counter += 1;
    const i = request_counter;
    console.log(`${i}>>> received request for language: ${language}`)

    let message;
    switch (language) {
        case 'fr':
            message = 'Bonjour, le monde!';
            break;
        case 'en':
            message = 'Hello, World!';
            break;
        case 'ar':
            message = 'مرحبا بالعالم!';
            break;
        default:
            message = 'Language not supported!';
            break;
    }

    callback(null, { message });
};

// Create the gRPC server
const server = new grpc.Server();
server.addService(helloWorldProto.HelloWorldService.service, { sayHello });

// Start the server
const PORT = argv.port;
server.bindAsync(`0.0.0.0:${PORT}`, grpc.ServerCredentials.createInsecure(), (error, port) => {
    if (error) {
        console.error(`Error starting server: ${error}`);
        return;
    }
    console.log(`'NodeJS' gRPC Server is running on port ${port}`);
});
