//
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = {
  '1': 'HelloRequest',
  '2': [
    {'1': 'language', '3': 1, '4': 1, '5': 9, '10': 'language'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode(
    'CgxIZWxsb1JlcXVlc3QSGgoIbGFuZ3VhZ2UYASABKAlSCGxhbmd1YWdl');

@$core.Deprecated('Use helloResponseDescriptor instead')
const HelloResponse$json = {
  '1': 'HelloResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloResponseDescriptor = $convert.base64Decode(
    'Cg1IZWxsb1Jlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use helloStreamRequestDescriptor instead')
const HelloStreamRequest$json = {
  '1': 'HelloStreamRequest',
  '2': [
    {'1': 'language', '3': 1, '4': 1, '5': 9, '10': 'language'},
    {'1': 'count', '3': 2, '4': 1, '5': 5, '10': 'count'},
    {'1': 'intervalMS', '3': 3, '4': 1, '5': 5, '10': 'intervalMS'},
  ],
};

/// Descriptor for `HelloStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloStreamRequestDescriptor = $convert.base64Decode(
    'ChJIZWxsb1N0cmVhbVJlcXVlc3QSGgoIbGFuZ3VhZ2UYASABKAlSCGxhbmd1YWdlEhQKBWNvdW'
    '50GAIgASgFUgVjb3VudBIeCgppbnRlcnZhbE1TGAMgASgFUgppbnRlcnZhbE1T');

@$core.Deprecated('Use helloStreamResponseDescriptor instead')
const HelloStreamResponse$json = {
  '1': 'HelloStreamResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'time', '3': 2, '4': 1, '5': 9, '10': 'time'},
  ],
};

/// Descriptor for `HelloStreamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloStreamResponseDescriptor = $convert.base64Decode(
    'ChNIZWxsb1N0cmVhbVJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USEgoEdGltZR'
    'gCIAEoCVIEdGltZQ==');

