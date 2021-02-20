FROM buildpack-deps:buster

WORKDIR /
COPY root /root/

WORKDIR /usr/src/perl
RUN true \
    && curl -SL https://www.cpan.org/src/5.0/perl-5.32.1.tar.xz -o perl-5.32.1.tar.xz \
    && echo '57cc47c735c8300a8ce2fa0643507b44c4ae59012bfdad0121313db639e02309 *perl-5.32.1.tar.xz' | sha256sum -c - \
    && tar --strip-components=1 -xaf perl-5.32.1.tar.xz -C /usr/src/perl \
    && rm perl-5.32.1.tar.xz \
    && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && archBits="$(dpkg-architecture --query DEB_BUILD_ARCH_BITS)" \
    && archFlag="$([ "$archBits" = '64' ] && echo '-Duse64bitall' || echo '-Duse64bitint')" \
    && ./Configure -Darchname="$gnuArch" "$archFlag" -Duseshrplib -Dvendorprefix=/usr/local  -des \
    && make -j$(nproc) \
    && TEST_JOBS=$(nproc) make test_harness \
    && make install \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "CPAN")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "CPAN::SQLite")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "CPAN::Reporter")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "ExtUtils::CBuilder")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "Module::Build")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "Archive::Tar")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "YAML")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "YAML::Syck")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "Test::Pod")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "Test::Pod::Coverage")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "Digest::SHA")' \
    && perl -MCPAN -e 'CPAN::Shell->notest("install", "version")'

WORKDIR /
CMD ["perl5.32.1","-de0"]
