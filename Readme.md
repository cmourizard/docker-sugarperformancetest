README
=============

Docker stack to run the Sugar 7.x Performance Test
------------------
This docker file contains the stack used to run the jmeter based load testing tool for Sugar 7.x based on Apache JMeter and available here: https://github.com/sugarcrm/performance
You can find more information and the process to request an access to this test suite on the official Sugar Developer Blog post: http://developer.sugarcrm.com/2015/07/27/sugar-7-unit-tests-and-performance-testing-tools-now-available/

1. Build the container
The first step is to clone this repo and build the container:
```sh
$ git clone
$ cd docker-sugarperformancetest
$ docker build -t sugarperformancetest .
```

2. Run the container
```sh
$ docker run -d \
    --volume /path/to/testsuite:/var/jmetersugar \
    --name sugarperformancetest \
    sugarperformancetest
$ docker exec -ti sugarperformancetest /bin/bash
$ root@ea98d2387c5b:
```

2. Login into the container and run the test suite
```sh
$ docker exec -ti sugarperformancetest /bin/bash
$ root@ea98d2387c5b:~# cd /var/jmetersugar/
```
And follow the instruction available in the Readme of the test suite