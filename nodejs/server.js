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

function getGreeting(language) {
    switch (language) {
        case 'fr':
            message = 'JavaScript dit Bonjour le monde';
            break;
        case 'en':
            message = 'JavaScript say Hello World';
            break;
        case 'ar':
            message = 'جافا سكربت يقول مرحبا بالعالم ';
            break;
        default:
            message = 'Language not supported!';
            break;
    }
    return message;

}
const sayHello = (call, callback) => {
    const { language } = call.request;
    request_counter += 1;
    const i = request_counter;
    console.log(`${i}>>> received request for language: ${language}`)

    // Get greeting message
    const greeting = getGreeting(language);
    callback(null, { message: greeting });
};

// Implementation of SayHelloManyTimes
function SayHelloManyTimes(call) {
    const { language, count, intervalMS } = call.request;
    request_counter += 1;
    const i = request_counter;
    console.log(`${i}>>> received Stream request for ${count} hellos in (${language}) with ${intervalMS} ms in between ...`)

    // Get greeting message
    const greeting = getGreeting(language);

    // Send multiple responses with time
    let sentCount = 0;
    const intervalId = setInterval(() => {
        if (sentCount >= count) {
            clearInterval(intervalId);
            call.end(); // End the stream
            return;
        }

        // Get current time
        const now = new Date().toISOString();

        // Create response message
        const response = {
            message: `${greeting} ${sentCount + 1}`,
            time: now,
        };

        call.write(response); // Stream the response to the client
        sentCount++;
    }, intervalMS); // Send a message every second
}

// Create the gRPC server
const server = new grpc.Server();
server.addService(helloWorldProto.HelloWorldService.service, { sayHello, SayHelloManyTimes });

// Start the server
const PORT = argv.port;
server.bindAsync(`0.0.0.0:${PORT}`, grpc.ServerCredentials.createInsecure(), (error, port) => {
    if (error) {
        console.error(`Error starting server: ${error}`);
        return;
    }
    console.log(`'NodeJS' gRPC Server is running on port ${port}`);
});
