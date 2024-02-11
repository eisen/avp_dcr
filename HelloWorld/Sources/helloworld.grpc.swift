//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: helloworld.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Helloworld_HelloWorldClient`, then call methods of this protocol to make API calls.
public protocol Helloworld_HelloWorldClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? { get }

  func sayHello(
    _ request: Helloworld_HelloRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Helloworld_HelloRequest, Helloworld_HelloResponse>
}

extension Helloworld_HelloWorldClientProtocol {
  public var serviceName: String {
    return "helloworld.HelloWorld"
  }

  /// Unary call to SayHello
  ///
  /// - Parameters:
  ///   - request: Request to send to SayHello.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func sayHello(
    _ request: Helloworld_HelloRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Helloworld_HelloRequest, Helloworld_HelloResponse> {
    return self.makeUnaryCall(
      path: Helloworld_HelloWorldClientMetadata.Methods.sayHello.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSayHelloInterceptors() ?? []
    )
  }
}

#if compiler(>=5.6)
@available(*, deprecated)
extension Helloworld_HelloWorldClient: @unchecked Sendable {}
#endif // compiler(>=5.6)

@available(*, deprecated, renamed: "Helloworld_HelloWorldNIOClient")
public final class Helloworld_HelloWorldClient: Helloworld_HelloWorldClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol?
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  public var interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the helloworld.HelloWorld service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

public struct Helloworld_HelloWorldNIOClient: Helloworld_HelloWorldClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol?

  /// Creates a client for the helloworld.HelloWorld service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#if compiler(>=5.6)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Helloworld_HelloWorldAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? { get }

  func makeSayHelloCall(
    _ request: Helloworld_HelloRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Helloworld_HelloRequest, Helloworld_HelloResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Helloworld_HelloWorldAsyncClientProtocol {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Helloworld_HelloWorldClientMetadata.serviceDescriptor
  }

  public var interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makeSayHelloCall(
    _ request: Helloworld_HelloRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Helloworld_HelloRequest, Helloworld_HelloResponse> {
    return self.makeAsyncUnaryCall(
      path: Helloworld_HelloWorldClientMetadata.Methods.sayHello.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSayHelloInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Helloworld_HelloWorldAsyncClientProtocol {
  public func sayHello(
    _ request: Helloworld_HelloRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Helloworld_HelloResponse {
    return try await self.performAsyncUnaryCall(
      path: Helloworld_HelloWorldClientMetadata.Methods.sayHello.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSayHelloInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct Helloworld_HelloWorldAsyncClient: Helloworld_HelloWorldAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Helloworld_HelloWorldClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#endif // compiler(>=5.6)

public protocol Helloworld_HelloWorldClientInterceptorFactoryProtocol: GRPCSendable {

  /// - Returns: Interceptors to use when invoking 'sayHello'.
  func makeSayHelloInterceptors() -> [ClientInterceptor<Helloworld_HelloRequest, Helloworld_HelloResponse>]
}

public enum Helloworld_HelloWorldClientMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "HelloWorld",
    fullName: "helloworld.HelloWorld",
    methods: [
      Helloworld_HelloWorldClientMetadata.Methods.sayHello,
    ]
  )

  public enum Methods {
    public static let sayHello = GRPCMethodDescriptor(
      name: "SayHello",
      path: "/helloworld.HelloWorld/SayHello",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
public protocol Helloworld_HelloWorldProvider: CallHandlerProvider {
  var interceptors: Helloworld_HelloWorldServerInterceptorFactoryProtocol? { get }

  func sayHello(request: Helloworld_HelloRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Helloworld_HelloResponse>
}

extension Helloworld_HelloWorldProvider {
  public var serviceName: Substring {
    return Helloworld_HelloWorldServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SayHello":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Helloworld_HelloRequest>(),
        responseSerializer: ProtobufSerializer<Helloworld_HelloResponse>(),
        interceptors: self.interceptors?.makeSayHelloInterceptors() ?? [],
        userFunction: self.sayHello(request:context:)
      )

    default:
      return nil
    }
  }
}

#if compiler(>=5.6)

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Helloworld_HelloWorldAsyncProvider: CallHandlerProvider {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Helloworld_HelloWorldServerInterceptorFactoryProtocol? { get }

  @Sendable func sayHello(
    request: Helloworld_HelloRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Helloworld_HelloResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Helloworld_HelloWorldAsyncProvider {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Helloworld_HelloWorldServerMetadata.serviceDescriptor
  }

  public var serviceName: Substring {
    return Helloworld_HelloWorldServerMetadata.serviceDescriptor.fullName[...]
  }

  public var interceptors: Helloworld_HelloWorldServerInterceptorFactoryProtocol? {
    return nil
  }

  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SayHello":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Helloworld_HelloRequest>(),
        responseSerializer: ProtobufSerializer<Helloworld_HelloResponse>(),
        interceptors: self.interceptors?.makeSayHelloInterceptors() ?? [],
        wrapping: self.sayHello(request:context:)
      )

    default:
      return nil
    }
  }
}

#endif // compiler(>=5.6)

public protocol Helloworld_HelloWorldServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'sayHello'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSayHelloInterceptors() -> [ServerInterceptor<Helloworld_HelloRequest, Helloworld_HelloResponse>]
}

public enum Helloworld_HelloWorldServerMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "HelloWorld",
    fullName: "helloworld.HelloWorld",
    methods: [
      Helloworld_HelloWorldServerMetadata.Methods.sayHello,
    ]
  )

  public enum Methods {
    public static let sayHello = GRPCMethodDescriptor(
      name: "SayHello",
      path: "/helloworld.HelloWorld/SayHello",
      type: GRPCCallType.unary
    )
  }
}
