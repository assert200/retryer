# retryer

## Synopsis

Provides 2 forms of retrying:

 * Retry - retry something (if an exception is raised) an amount of times (Default 5)
 * Wait - retry something (to be true) for a duration of time (Default 5 seconds) 
 

## Retryer Code Example 
```ruby
require 'retryer'
retryer = Retryer::Retry.new(max_retries: 5, interval: 1)
counter = 0
retryer.do { raise "Connection Failed." }
```

## Wait Code Example 
```ruby
require 'retryer'
wait = Retryer::Wait.new(timeout: 5, interval: 1)
counter = 0
wait.until { 6 < counter += 1 }
```

## Motivation

Created for automation testing where retrying and waiting is required.

## Installation

gem install retryer

## Contributors

Feedback and contributions are very welcome.

## License

MIT
 
 
