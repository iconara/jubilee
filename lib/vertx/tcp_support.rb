# Copyright 2011-2012 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Vertx

  # Mixin module that provides all the common TCP params that can be set.
  #
  # @author {http://tfox.org Tim Fox}
  module TCPSupport

    # Set the TCP send buffer size.
    # @param [FixNum] val. The size in bytes.
    # @return [] A reference to self so invocations can be chained
    def send_buffer_size=(val)
      @j_del.setSendBufferSize(val)
      self
    end

    # Set or get send buffer size for fluent API
    def send_buffer_size(val = nil)
      if val
        @j_del.setSendBufferSize(val)
        self
      else
        @j_del.getSendBufferSize
      end
    end

    # Set the TCP receive buffer size.
    # @param [FixNum] val. The size in bytes.
    # @return [] A reference to self so invocations can be chained
    def receive_buffer_size=(val)
      @j_del.setReceiveBufferSize(val)
      self
    end

    # Set or get send buffer size for fluent API
    def send_receive_size(val = nil)
      if val
        @j_del.setReceiveBufferSize(val)
        self
      else
        @j_del.getReceiveBufferSize
      end
    end

    # Set the TCP keep alive setting.
    # @param [Boolean] val. If true, then TCP keep alive will be enabled.
    # @return [] A reference to self so invocations can be chained
    def tcp_keep_alive=(val)
      @j_del.setTCPKeepAlive(val)
      self
    end

    # Set or get TCP keep alive for fluent API
    def tcp_keep_alive(val = nil)
      if val
        @j_del.setTCPKeepAlive(val)
        self
      else
        @j_del.getTCPKeepAlive
      end
    end

    # Set the TCP reuse address setting.
    # @param [Boolean] val. If true, then TCP reuse address will be enabled.
    # @return [] A reference to self so invocations can be chained
    def reuse_address=(val)
      @j_del.setReuseAddress(val)
      self
    end

    # Set or get TCP reuse address for fluent API
    def reuse_address(val = nil)
      if val
        @j_del.setReuseAddress(val)
        self
      else
        @j_del.isReuseAddress
      end
    end

    # Set the TCP so linger setting.
    # @param [FixNum] val. Set TCP soLinger
    # @return [] A reference to self so invocations can be chained
    def so_linger=(val)
      @j_del.setSoLinger(val)
      self
    end

    # Set or get TCP so linger for fluent API
    def so_linger(val = nil)
      if val
        @j_del.setSoLinger(val)
        self
      else
        @j_del.getSoLinger
      end
    end

    # Set the TCP traffic class setting.
    # @param [FixNum] val. The TCP traffic class setting.
    # @return [] A reference to self so invocations can be chained
    def traffic_class=(val)
      @j_del.setTrafficClass(val)
      self
    end

    # Set or get TCP traffic class for fluent API
    def traffic_class(val = nil)
      if val
        @j_del.setTrafficClass(val)
        self
      else
        @j_del.getTrafficClass
      end
    end

    # Set to use pooled buffers
    # @param [Boolean] val.
    # @return [] A reference to self so invocations can be chained
    def use_pooled_buffers=(val)
      @j_del.setUsedPooledBuffers(val)
      self
    end

    # Set or get use_pooled_buffers for fluent API
    def use_pooled_buffers(val = nil)
      if val
        @j_del.setUsePooledBuffers(val)
        self
      else
        @j_del.isUsePooledBuffers
      end
    end

  end

end
