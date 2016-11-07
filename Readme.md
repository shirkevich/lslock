Usage:

1. docker build -t lslock .
2. docker run -it lslock rspec

To test it by hand:

1. docker run -it lslock bash
2. ./spec/lslock-test.rb &
3. ./bin/lslock /tmp
