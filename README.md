# wscr
A Crystal implementation of wscat

## Usage

Display help:

```
ws -h
    -h, --help                       display help information
    -c, --connect=<url>              connect to a server
    -u, --user=<username>            configure basic auth with a username
```

Connect to a WebSocket server:

```
ws -c http://some_server -u rob
```