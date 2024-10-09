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
    }).option('count', {
        alias: 'c',
        description: 'Number of replies to request from the server (uses gRPC stream if set to > 1)',
        type: 'number',
        default: 1,  // You can set a default value if desired
    })
    .option('intervalMS', {
        alias: 'ims',
        description: 'Delay in milliseconds between server stream responses (for count > 1)',
        type: 'number',
        default: 1000, // Set a default delay of 1000 ms (1 second)
    })
    .help()
    .argv;

const language = argv._[0];
const languages = ['fr', 'en', 'ar'];
const count = argv.count;
const intervalMS = argv.intervalMS;

if (!argv.randomTest && !language) {
    console.error('Error: Language argument is required. Please provide a language (fr, en, ar). (use --help for more information');
    process.exit(1);
}
if (count <= 0) {
    console.error('Error: --count argument must be greater than 0. (use --help for more information).');
    process.exit(1);
}

if (count > 1 && intervalMS < 0) {
    console.error('Error: --interval_ms argument must be greaterthan or equal to 0 (use --help for more information).');
    process.exit(1);
}

const PROTO_PATH = "../protos/helloworld.proto";
const packageDefinition = protoLoader.loadSync(PROTO_PATH, {});
const helloWorldProto = grpc.loadPackageDefinition(packageDefinition).helloworld;

const client = new helloWorldProto.HelloWorldService(`${argv.ip}:${argv.port}`, grpc.credentials.createInsecure());

const callSayHello = (language) => {
    console.log(`--> sent gRPC request (${language})...`)

    client.sayHello({ language }, (error, response) => {
        if (error) {
            console.error(`Error: ${error.message}`);
        } else {
            console.log(`Response: ${response.message}`);
        }
    });
};

function callSayHelloManyTimes(language, count,intervalMS, onEnd = () => { }) {

    const request = {
        language,
        count,
        intervalMS,
    };
    console.log(`--> sent gRPC request ${count} hellos in (${language}) with ${intervalMS} ms in between ...`)

    const call = client.SayHelloManyTimes(request);

    call.on('data', (response) => {
        console.log(`[${response.time}] Message: ${response.message}`);
    });

    call.on('end', () => {
        console.log('Stream ended.');
        onEnd();
    });

    call.on('error', (error) => {
        console.error(error);
    });
}


if (count == 1) {
    if (argv.randomTest) {

        // call SayHello every 1s with a random language
        setInterval(() => {
            const randomLanguage = languages[Math.floor(Math.random() * languages.length)];
            callSayHello(randomLanguage);
        }, 1000);


    } else {
        // call SayHello once with the specified language
        callSayHello(language);
    }
} else if (count > 1) {
    if (argv.randomTest) {
        const onEnd = () => {
            callSayHelloManyTimes(language, argv.count,intervalMS, onEnd);
        }
        callSayHelloManyTimes(language, argv.count,intervalMS, onEnd);

    }
    else {
        callSayHelloManyTimes(language, argv.count,intervalMS);
    }
}
