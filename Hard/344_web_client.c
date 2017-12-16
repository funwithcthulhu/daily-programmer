/*
Description
Today's challenge is simple: write a web client from scratch.

Requirements:

Given an HTTP URL (no need to support TLS or HTTPS),
fetch the content using a GET request

Display the content on the console (a'la curl)

Exit


For the challenge, your requirements are similar to the HTTP server
challenge - implement a thing you use often from scratch instead of
using your language's built in functionality:

You may not use any of your language's built in web client functionality
or any third party library or tool. E.g. you can't use Python's urllib,
httplib, or a third-party module like requests or curl. Same for any other
language and their built in features; you may also not shell out to something
like curl (e.g. no system("curl %s", url)).

Your program should use string processing calls to dissect the URL
(again, you cannot use any of the built in functionality like Python's
urlparse module or Java's java.net.URL, or third-party URL parsing libraries like HTParse).

Your program should support non-standard ports (for instance http://server.io:8080/).

Your program does NOT need to support TLS or SSL.

Your program should use low level socket() calls (or equivalent) to connect
to the server, and make a well-formatted HTTP/1.1 request. That's the whole
point of the challenge!

A good test server is httpbin, which can give you all sorts of feedback about your
client's behavior; another is requestb.in.

Example Output

Here is some simple bare-bones output from httpbin.org:

HTTP/1.1 200 OK
Connection: keep-alive
Server: meinheld/0.6.1
Date: Fri, 15 Dec 2017 17:14:03 GMT
Content-Type: application/json
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
X-Powered-By: Flask
X-Processed-Time: 0.00114393234253
Content-Length: 158
Via: 1.1 vegur

{
  "args": {},
  "headers": {
    "Connection": "close",
    "Host": "httpbin.org"
  },
  "origin": "1.2.3.4",
  "url": "http://httpbin.org/get"
}

If your client can emit that kind of thing to standard out, you're set.

Bonus
The above focuses on a simple client. Here are a few more things you can do to extend it:

Support POST requests (and feeding the data)
Support authentication
Support arbitrary additional headers or overwriting headers
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <netdb.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h> 

#define HTTP_GET_MSG "GET %s HTTP/1.1\r\nHost:%s\r\n\r\n"

int client(char *host, char *loc, char *port);
char* getLoc(char *url);
void formatURL(char *url);

int main(int argc, char* argv[])
{
	if (argc != 3) {
		fprintf(stderr, "Usage: %s <url/location> <port>\n", argv[0]);
		return 1;
	}
	int length = strlen(argv[1]) + 1;
	char *url = calloc(length, sizeof(char));
	strcpy(url, argv[1]);
	formatURL(url);

	char *loc = calloc(length, sizeof(char));
	strcpy(loc, argv[1]);
	loc = getLoc(loc);

	int n = client(url, loc, argv[2]);
	free(url);

	return n;
}

int client(char *host, char *loc, char *port)
{
	char buffer[2048];
	char header[128];

	struct addrinfo hints;
	memset(&hints, 0, sizeof(hints));
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;

	struct addrinfo *serverinfo;
	memset(&serverinfo, 0, sizeof(serverinfo));
	int status = getaddrinfo(host, port, &hints, &serverinfo);
	int sockt = socket(serverinfo->ai_family,
					   serverinfo->ai_socktype,
					   serverinfo->ai_protocol);

	connect(sockt, serverinfo->ai_addr, serverinfo->ai_addrlen);
	freeaddrinfo(serverinfo);

	snprintf(header, 128, HTTP_GET_MSG, loc, host);
	int n = write(sockt, header, strlen(header));
	n = read(sockt, buffer, 2048);
	printf("%s\n", buffer);
	
	return 0;
}

char* getLoc(char *url)
{
	char *pt;
	pt = url;
	int length = strlen(pt);
	int i = 0;
	pt += length - 1;
    while (*pt!= '/') {
		pt--;
		i++;
		if (i == length) {
			pt = "/";
			break;
		}
	}   
	return pt;
}

void formatURL(char *url)
{
	char *pt;
	pt = url;
	while (*pt != '/') {
		pt++;
	}
	*pt = '\0';
}