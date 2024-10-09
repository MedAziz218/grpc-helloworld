//
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'helloworld.pb.dart' as $0;

export 'helloworld.pb.dart';

@$pb.GrpcServiceName('helloworld.HelloWorldService')
class HelloWorldServiceClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
      '/helloworld.HelloWorldService/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloResponse.fromBuffer(value));
  static final _$sayHelloManyTimes = $grpc.ClientMethod<$0.HelloStreamRequest, $0.HelloStreamResponse>(
      '/helloworld.HelloWorldService/SayHelloManyTimes',
      ($0.HelloStreamRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloStreamResponse.fromBuffer(value));

  HelloWorldServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloResponse> sayHello($0.HelloRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseStream<$0.HelloStreamResponse> sayHelloManyTimes($0.HelloStreamRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sayHelloManyTimes, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('helloworld.HelloWorldService')
abstract class HelloWorldServiceBase extends $grpc.Service {
  $core.String get $name => 'helloworld.HelloWorldService';

  HelloWorldServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloStreamRequest, $0.HelloStreamResponse>(
        'SayHelloManyTimes',
        sayHelloManyTimes_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HelloStreamRequest.fromBuffer(value),
        ($0.HelloStreamResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloResponse> sayHello_Pre($grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Stream<$0.HelloStreamResponse> sayHelloManyTimes_Pre($grpc.ServiceCall call, $async.Future<$0.HelloStreamRequest> request) async* {
    yield* sayHelloManyTimes(call, await request);
  }

  $async.Future<$0.HelloResponse> sayHello($grpc.ServiceCall call, $0.HelloRequest request);
  $async.Stream<$0.HelloStreamResponse> sayHelloManyTimes($grpc.ServiceCall call, $0.HelloStreamRequest request);
}
