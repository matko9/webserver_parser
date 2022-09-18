# README
Webserver log parser script receives a log as an argument and returns:
- list of webpages with most page views ordered from most page views to less page views
- list of webpages with most unique page views ordered from most unique page views to less unique page views

How to run the script:
```sh
$ ./bin/parser.rb webserver.log
```

How to run the test suite:
```sh
$ rspec
```