
NETSPY_PATH=`pwd`.chomp("\n")+"/../libnetspy.so"

EXECUTABLE="../tcpsnitch"
LD_PRELOAD="LD_PRELOAD=../libtcpsnitch.so.1.0"
TEST_DIR="/tmp/netspy"

PACKET_DRILL="packetdrill --tolerance_usecs=10000000"

# packetdrill scripts
PKT_SCRIPTS_PATH="./pkt_scripts"

DEFAULT_PATH="/tmp/netspy"
JSON_FILE="dump.json"
PCAP_FILE="dump.pcap"

# LOGS
PROCESS_DIR_REGEX="*.out*"
LOG_FILE="*.log"
LOG_LABEL_ERROR="[ERROR]"
LOG_LABEL_WARN="[WARN]"
LOG_LABEL_INFO="[INFO]"

# LOGS LVL
LOG_LVL_ALWAYS  = 0
LOG_LVL_ERROR   = 1
LOG_LVL_WARN    = 2
LOG_LVL_INFO    = 3
LOG_LVL_DEBUG   = 4

# EVENTS

# sys/socket.h
TCP_EV_SOCKET="socket"
TCP_EV_BIND="bind"
TCP_EV_CONNECT="connect"
TCP_EV_SHUTDOWN="shutdown"
TCP_EV_LISTEN="listen"
TCP_EV_ACCEPT="accept"
TCP_EV_ACCEPT4="accept4"
TCP_EV_GETSOCKOPT="getsockopt"
TCP_EV_SETSOCKOPT="setsockopt"
TCP_EV_SEND="send"
TCP_EV_RECV="recv"
TCP_EV_SENDTO="sendto"
TCP_EV_RECVFROM="recvfrom"
TCP_EV_SENDMSG="sendmsg"
TCP_EV_RECVMSG="recvmsg"
TCP_EV_SENDMMSG="sendmmsg"
TCP_EV_RECVMMSG="recvmmsg"
TCP_EV_GETSOCKNAME="getsockname"
TCP_EV_GETPEERNAME="getpeername"
TCP_EV_SOCKATMARK="sockatmark"
TCP_EV_ISFDTYPE="isfdtype"

# unistd.h
TCP_EV_WRITE="write"
TCP_EV_READ="read"
TCP_EV_CLOSE="close"
TCP_EV_DUP="dup"
TCP_EV_DUP2="dup2"
TCP_EV_DUP3="dup3"

# sys/uio.h
TCP_EV_WRITEV="writev"
TCP_EV_READV="readv"
TCP_EV_IOCTL="ioctl"

# sys/sendfile.h
TCP_EV_SENDFILE="sendfile"

# poll.h
TCP_EV_POLL="poll"
TCP_EV_PPOLL="ppoll"

# sys/select.h
TCP_EV_SELECT="select"
TCP_EV_PSELECT="pselect"

# fcntl.h
TCP_EV_FCNTL="fcntl"

# epoll.h
TCP_EV_EPOLL_CTL="epoll_ctl"
TCP_EV_EPOLL_WAIT="epoll_wait"
TCP_EV_EPOLL_PWAIT="epoll_pwait"

# stdio.h
TCP_EV_FDOPEN="fdopen"

TCP_EV_TCP_INFO="tcp_info"

SOCKET_SYSCALLS = [
  TCP_EV_SOCKET,
  TCP_EV_BIND,
  TCP_EV_CONNECT,
  TCP_EV_SHUTDOWN,
  TCP_EV_LISTEN,
#  TCP_EV_ACCEPT,
#  TCP_EV_ACCEPT4,
  TCP_EV_GETSOCKOPT,
  TCP_EV_SETSOCKOPT,
  TCP_EV_SEND,
  TCP_EV_RECV,
  TCP_EV_SENDTO,
  TCP_EV_RECVFROM,
  TCP_EV_SENDMSG,
  TCP_EV_RECVMSG,
  TCP_EV_SENDMMSG,
	TCP_EV_RECVMMSG,
  TCP_EV_GETSOCKNAME,  
  TCP_EV_GETPEERNAME,
  TCP_EV_SOCKATMARK,
  TCP_EV_ISFDTYPE,
  TCP_EV_WRITE,
  TCP_EV_READ,
  TCP_EV_CLOSE,
  TCP_EV_DUP,
  TCP_EV_DUP2,
  TCP_EV_DUP3,
  TCP_EV_WRITEV,
  TCP_EV_READV,
  TCP_EV_IOCTL,
  TCP_EV_SENDFILE,
  TCP_EV_POLL,
  TCP_EV_PPOLL,
  TCP_EV_SELECT,
  TCP_EV_PSELECT,
  TCP_EV_FCNTL,
  TCP_EV_EPOLL_CTL,
  TCP_EV_EPOLL_WAIT,
  TCP_EV_EPOLL_PWAIT,
  TCP_EV_ISFDTYPE
]


