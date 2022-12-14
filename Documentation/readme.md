## Documentation

All documentation regardless of where it is should be in markdown.
Formatting asside , it can be easily converted to HTML. Making storing and displaying it very convienient.


### Sample
*View below here as RAW not as it is displayed currently*


## Usage

```
usage: client.py [-h] [-p PORT] [-s SERVER] [-u USER] [-P PASSWORD]

optional arguments:
  -h, --help            show this help message and exit
  -p PORT, --port PORT  Port to connect to
  -s SERVER, --server SERVER
                        Server to connect to
  -u USER, --user USER  Username to login with
  -P PASSWORD, --password PASSWORD
                        Password to login with
```

## Example

```
$ python3 client.py -s 127.0.0.1 -p 1337 -u test -P test
[*] Connecting to 127.0.0.1:1337
[*] Authenticating with username: test and password: test
[*] Authenticated!
[*] Starting shell
$ ls
client.py
server.py
$ exit
[*] Exiting
```

# Sample Markdown

This is some basic, sample markdown.

## Second Heading

 * Unordered lists, and:
  1. One
  1. Two
  1. Three
 * More

> Blockquote

And **bold**, *italics*, and even *italics and later **bold***. Even ~~strikethrough~~. [A link](https://markdowntohtml.com) to somewhere.

And code highlighting:

```js
var foo = 'bar';

function baz(s) {
   return foo + ':' + s;
}
```

Or inline code like `var foo = 'bar';`.

Or an image of bears

![bears](http://placebear.com/200/200)

The end ...
