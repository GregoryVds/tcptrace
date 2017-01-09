# Purpose: test the JSON output file of a given TCP connection
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require './lib/lib.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "tcp_spy" do
  MiniTest::Unit.after_tests { WebServer.stop }
	
  before do
    WebServer.start
    reset_dir(DEFAULT_PATH) 
  end

  describe "2 TCP connections" do
    it "should properly handle 2 consecutive connections" do
      run_c_program("consecutive_connections")
      pattern0 = [
        {type: TCP_EV_SOCKET}.ignore_extra_keys!,
        {type: TCP_EV_CLOSE}.ignore_extra_keys!
      ].ignore_extra_values!
      pattern1 = [
        {type: TCP_EV_SOCKET}.ignore_extra_keys!,
        {type: TCP_EV_CLOSE}.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern0, read_json(0))
      assert_json_match(pattern1, read_json(1))
    end

    it "should properly handle 2 concurrent connections" do
      run_c_program("concurrent_connections")
      pattern0 = [
        {type: TCP_EV_SOCKET}.ignore_extra_keys!,
        {type: TCP_EV_CLOSE}.ignore_extra_keys!
      ].ignore_extra_values!
      pattern1 = [
        {type: TCP_EV_SOCKET}.ignore_extra_keys!,
        {type: TCP_EV_CLOSE}.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern0, read_json(0))
      assert_json_match(pattern1, read_json(1))
    end
  end

  describe "an event" do
    it "should have the correct shared fields" do
      run_c_program("socket")
      pattern = [
        {
          details: Hash,
          return_value: Fixnum,
          success: Boolean,
          timestamp: {
            sec: Fixnum,
            usec: Fixnum
          },
          type: String
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end
 
  describe "a #{TCP_EV_SOCKET} event" do
    it "#{TCP_EV_SOCKET}should have the correct JSON fields" do
      run_c_program(TCP_EV_SOCKET)
      pattern = [
        {
          type: TCP_EV_SOCKET,
          details: {
            domain: String,
            protocol: Fixnum,
            sock_cloexec: Boolean,
            sock_nonblock: Boolean,
            type: String
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_BIND} event" do
    it "#{TCP_EV_BIND} should have the correct JSON fields" do
      run_c_program(TCP_EV_BIND)
      pattern = [
        {
          type: TCP_EV_BIND,
          details: {
            addr: {
              ip: String,
              port: String,
              name: String,
              serv: String
            },
            force_bind: Boolean,
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_CONNECT} event" do
    it "#{TCP_EV_CONNECT} should have the correct JSON fields" do
      run_c_program(TCP_EV_CONNECT)
      pattern = [
        {
          type: TCP_EV_CONNECT,
          details: {
            addr: {
              ip: String,
              port: String,
              name: String,
              serv: String
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_SHUTDOWN} event" do
    it "#{TCP_EV_SHUTDOWN} should have the correct JSON fields" do
      run_c_program(TCP_EV_SHUTDOWN)
      pattern = [
        {
          type: TCP_EV_SHUTDOWN,
          details: {
            shut_rd: Boolean,
            shut_wr: Boolean
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_LISTEN} event" do
    it "#{TCP_EV_LISTEN} should have the correct JSON fields" do
      run_c_program(TCP_EV_LISTEN)
      pattern = [
        {
          type: TCP_EV_LISTEN,
          details: {
            backlog: Fixnum
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_SETSOCKOPT} event" do
    it "#{TCP_EV_SETSOCKOPT} should have the correct JSON fields" do
      run_c_program(TCP_EV_SETSOCKOPT)
      pattern = [
        {
          type: TCP_EV_SETSOCKOPT,
          details: {
            level: Fixnum,
            level_str: String,
            optname: Fixnum,
            optname_str: String
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_SEND} event" do
    it "#{TCP_EV_SEND} should have the correct JSON fields" do
      run_c_program(TCP_EV_SEND)
      pattern = [
        {
          type: TCP_EV_SEND,
          details: {
            bytes: Fixnum,
            flags: {
              msg_confirm: Boolean,
              msg_dontroute: Boolean,
              msg_dontwait: Boolean,
              msg_eor: Boolean,
              msg_more: Boolean,
              msg_nosignal: Boolean,
              msg_oob: Boolean
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_RECV} event" do
    it "#{TCP_EV_RECV} should have the correct JSON fields" do
      run_c_program(TCP_EV_RECV)
      pattern = [
        {
          type: TCP_EV_RECV,
          details: {
            bytes: Fixnum,
            flags: {
              msg_cmsg_cloexec: Boolean,
              msg_dontwait: Boolean,
              msg_errqueue: Boolean,
              msg_oob: Boolean,
              msg_peek: Boolean,
              msg_trunc: Boolean,
              msg_waitall: Boolean
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_SENDTO} event" do
    it "#{TCP_EV_SENDTO} should have the correct JSON fields" do
      run_c_program(TCP_EV_SENDTO)
      pattern = [
        {
          type: TCP_EV_SENDTO,
          details: {
            bytes: Fixnum,
            flags: {
              msg_confirm: Boolean,
              msg_dontroute: Boolean,
              msg_dontwait: Boolean,
              msg_eor: Boolean,
              msg_more: Boolean,
              msg_nosignal: Boolean,
              msg_oob: Boolean
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_RECVFROM} event" do
    it "#{TCP_EV_RECVFROM} should have the correct JSON fields" do
      run_c_program(TCP_EV_RECVFROM)
      pattern = [
        {
          type: TCP_EV_RECVFROM,
          details: {
            bytes: Fixnum,
            flags: {
              msg_cmsg_cloexec: Boolean,
              msg_dontwait: Boolean,
              msg_errqueue: Boolean,
              msg_oob: Boolean,
              msg_peek: Boolean,
              msg_trunc: Boolean,
              msg_waitall: Boolean
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_SENDMSG} event" do
    it "#{TCP_EV_SENDMSG} should have the correct JSON fields" do
      run_c_program(TCP_EV_SENDMSG)
      pattern = [
        {
          type: TCP_EV_SENDMSG,
          details: {
            bytes: Fixnum,
            flags: {
              msg_confirm: Boolean,
              msg_dontroute: Boolean,
              msg_dontwait: Boolean,
              msg_eor: Boolean,
              msg_more: Boolean,
              msg_nosignal: Boolean,
              msg_oob: Boolean
            },
            msghdr: {
              control_data: Boolean,
              iovec: {
                iovec_count: Fixnum,
                iovec_sizes: Array
              }
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_RECVMSG} event" do
    it "#{TCP_EV_RECVMSG} should have the correct JSON fields" do
      run_c_program(TCP_EV_RECVMSG)
      pattern = [
        {
          type: TCP_EV_RECVMSG,
          details: {
            bytes: Fixnum,
            flags: {
              msg_cmsg_cloexec: Boolean,
              msg_dontwait: Boolean,
              msg_errqueue: Boolean,
              msg_oob: Boolean,
              msg_peek: Boolean,
              msg_trunc: Boolean,
              msg_waitall: Boolean
            },
            msghdr: {
              control_data: Boolean,
              iovec: {
                iovec_count: Fixnum,
                iovec_sizes: Array
              }
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_WRITE} event" do
    it "#{TCP_EV_WRITE} should have the correct JSON fields" do
      run_c_program(TCP_EV_WRITE)
      pattern = [
        {
          type: TCP_EV_WRITE,
          details: {
            bytes: Fixnum
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_READ} event" do
    it "#{TCP_EV_READ} should have the correct JSON fields" do
      run_c_program(TCP_EV_READ)
      pattern = [
        {
          type: TCP_EV_READ,
          details: {
            bytes: Fixnum
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_CLOSE} event" do
    it "#{TCP_EV_CLOSE} should have the correct JSON fields" do
      run_c_program(TCP_EV_CLOSE)
      pattern = [
        {
          type: TCP_EV_CLOSE,
          details: {
            detected: Boolean
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_WRITEV} event" do
    it "#{TCP_EV_WRITEV} should have the correct JSON fields" do
      run_c_program(TCP_EV_WRITEV)
      pattern = [
        {
          type: TCP_EV_WRITEV,
          details: {
            bytes: Fixnum,
            iovec: {
              iovec_count: Fixnum,
              iovec_sizes: Array
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_READV} event" do
    it "#{TCP_EV_READV} should have the correct JSON fields" do
      run_c_program(TCP_EV_READV)
    pattern = [
        {
          type: TCP_EV_READV,
          details: {
            bytes: Fixnum,
            iovec: {
              iovec_count: Fixnum,
              iovec_sizes: Array
            }
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end

  describe "a #{TCP_EV_TCP_INFO} event" do
    it "#{TCP_EV_TCP_INFO} should have the correct JSON fields" do
      tcpsnitch("-u 0 -b 0 -d #{TEST_DIR}", "./c_programs/*socket.out")
      pattern = [
        {
          type: TCP_EV_TCP_INFO,
          details: {
            state: Fixnum,
            ca_state: Fixnum,
            retransmits: Fixnum,
            probes: Fixnum,
            backoff: Fixnum,
            options: Fixnum,
            snd_wscale: Fixnum,
            rcv_wscale: Fixnum,
            rto: Fixnum,
            ato: Fixnum,
            snd_mss: Fixnum,
            rcv_mss: Fixnum,
            unacked: Fixnum,
            sacked: Fixnum,
            lost: Fixnum,
            retrans: Fixnum,
            fackets: Fixnum,
            last_data_sent: Fixnum,
            last_ack_sent: Fixnum,
            last_data_recv: Fixnum,
            last_ack_recv: Fixnum,
            pmtu: Fixnum,
            rcv_ssthresh: Fixnum,
            rtt: Fixnum,
            rttvar: Fixnum,
            snd_ssthresh: Fixnum,
            snd_cwnd: Fixnum,
            advmss: Fixnum,
            reordering: Fixnum,
            rcv_rtt: Fixnum,
            rcv_space: Fixnum,
            total_retrans: Fixnum,
          }
        }.ignore_extra_keys!
      ].ignore_extra_values!
      assert_json_match(pattern, read_json)
    end
  end
end