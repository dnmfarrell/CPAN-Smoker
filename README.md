CPAN-Smoker
-----------
A bare bones dockerfile to smoke CPAN, this is a work in progress.

The included [distroprefs](https://github.com/rurban/distroprefs) help the cpan client ignore, patch or otherwise amend cpan distributions. Thanks Reini

Instructions
------------
1. Install [minicpan](https://metacpan.org/pod/distribution/CPAN-Mini/bin/minicpan) and download all of CPAN.
2. Copy your `mirrors/minicpan` dir to `./root/mirrors/minicpan`
3. Build the docker image: `docker build -t cpan-smoker-v5.32.1 -f Dockerfile-v5.32.1 .`
4. Run the docker image with no networking and stop logs from eating all of your disk: `docker run -it --network none --log-opt max-size=10m --log-opt max-file=3 cpan-smoker-v5.32.1 /bin/bash`
7. Run `/root/smoke`
8. Watch reports appear in `/root/.cpanreporter/reports`.

Troubleshooting
---------------
If a distribution prompts for input or a test hangs:
1. Copy the name of the distribution
2. Shell into the container and run `/root/kill-laggards` to skip the install
3. Add the distribution to `/root/.cpan/prefs/01.DISABLED.yml`


Copyright 2021 David Farrell

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
