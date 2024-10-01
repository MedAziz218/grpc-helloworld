const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const yargs = require('yargs');

const argv = yargs
    .usage('Usage: $0 [language]')
    .option('port', {
        alias: 'p',
        description: 'Port of the gRPC server',
        type: 'number',
        default: 9999,
    })
    .option('ip', {
        alias: 'i',
        description: 'IP address of the gRPC server',
        type: 'string',
        default: '127.0.0.1',
    })
    .option('random-test', {
        alias: 'r',
        description: 'Send requests randomly every second',
        type: 'boolean',
        default: false,
    })
    .help()
    .argv;

const language = argv._[0];
const languages = ['fr', 'en', 'ar'];

if (!argv.randomTest && !language) {
    console.error('Error: Language argument is required. Please provide a language (fr, en, ar).');
    process.exit(1);
}

const PROTO_PATH = "../protos/helloworld.proto";
const packageDefinition = protoLoader.loadSync(PROTO_PATH, {});
const helloWorldProto = grpc.loadPackageDefinition(packageDefinition).helloworld;

const client = new helloWorldProto.HelloWorldService(`${argv.ip}:${argv.port}`, grpc.credentials.createInsecure());

const sendRequest = (language) => {
    console.log(`--> sent gRPC request (${language})...`)

    client.sayHello({ language }, (error, response) => {
        if (error) {
            console.error(`Error: ${error.message}`);
        } else {
            console.log(`Response: ${response.message}`);
        }
    });
};

if (argv.randomTest) {
    setInterval(() => {
        const randomLanguage = languages[Math.floor(Math.random() * languages.length)];
        sendRequest(randomLanguage);
    }, 1000);
} else {
    sendRequest(language);
}
