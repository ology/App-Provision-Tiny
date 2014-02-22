#!/usr/bin/env perl
use strict;
use warnings;

use File::Which;
use Getopt::Simple qw($switch);

my $options = {
    help => {
        type    => '',
        env     => '-',
        default => '',
    },
    program => {
        type    => '=s',
        default => '',
        verbose => '* Required. The program to install',
    },
    keytype => {
        type    => '=s',
        default => 'rsa',
        verbose => 'ssh key type [rsa]',
    },
    keyname => {
        type    => '=s',
        default => '',
        verbose => 'ssh key name e.g. github',
    },
    repo => {
        type    => '=s',
        default => 'repo',
        verbose => 'Personal repository root [repo]',
    },
    site => {
        type    => '=s',
        default => 'localhost',
        verbose => 'The name in chameleon5/domains/name',
    },
};
my $usage = "Usage: perl $0 --program=foo [--options]";
my $option = Getopt::Simple->new;
if (! $option->getOptions($options, $usage) ) {
    exit -1; # Failure.
}
#use Data::Dumper;die
#Data::Dumper->new([$switch])->Indent(1)->Terse(1)->Quotekeys(0)->Sortkeys(1)->Dump;

# Conditional errors.
die $usage unless $switch->{program};
die "Program 'ssh' must include keytype and keyname\n"
    if $switch->{program} eq 'ssh' && !($switch->{keytype} && $switch->{keyname});
die "Program 'chameleon' must include repo\n"
    if $switch->{program} eq 'chameleon' && !$switch->{repo};
die "Program 'update' must include repo\n"
    if $switch->{program} eq 'update' && !$switch->{repo};
die "Program 'foundation' must include site\n"
    if $switch->{program} eq 'foundation' && !$switch->{site};

my $keyfile = sprintf '%s/.ssh/id_%s-%s', $ENV{HOME}, $switch->{keytype}, $switch->{keyname};
my $repo = $switch->{repo};
my $site = "$repo/chameleon5/domains/$switch->{site}/site_root";

my $provision = {
  sequelpro => {
    condition => sub { -d '/Applications/Sequel Pro.app' },
    commands  => [
      [ 'wget', 'https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg', '-P', "$ENV{HOME}/Downloads/" ],
      [ 'hdiutil', 'attach', "$ENV{HOME}/Downloads/sequel-pro-1.0.2.dmg", ],
      [ 'cp', '-r', '/Volumes/Sequel Pro 1.0.2/Sequel Pro.app', '/Applications/' ],
      [ 'hdiutil', 'detach', '/Volumes/Sequel Pro 1.0.2' ],
    ],
  },
  ssh => {
    condition => sub { -e $keyfile },
    commands  => [
      [ 'ssh-keygen', '-t', $switch->{keytype}, '-f', $keyfile ],
      [ "cat $keyfile.pub | tr -d '\n' | pbcopy" ],
      [ 'echo', '* Now paste your public key into https://github.com/settings/ssh *' ],
    ],
  },
  homebrew => {
    condition => sub { which('brew') },
    commands  => [
      [ 'ruby', '-e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"' ],
      [ 'brew', 'doctor' ],
    ],
  },
  git => {
    condition => sub { which('git') },
    commands  => [
      [qw( brew install git )],
    ],
  },
  mysql => {
    condition => sub { which('mysql') },
    commands  => [
      [qw( brew install mysql )],
    ],
  },
  perlbrew => {
    condition => sub { which('perlbrew') },
    commands  => [
      [ 'curl -L http://install.perlbrew.pl | bash' ],
      [ "echo 'source ~/perl5/perlbrew/etc/bashrc >> $ENV{HOME}/.bash_profile" ],
      [qw( perlbrew install perl-5.18.2 )],
      [qw( perlbrew switch perl-5.18.2 )],
    ],
  },
  chameleon5 => {
    condition => sub { -d "$repo/chameleon5" },
    commands  => [
      [ qw( git clone git@github.com:Whapps/chameleon5.git ), "$repo/chameleon5" ],
      [ 'cp', "$repo/chameleon5/bin/sample_dev_c5.pl", "$repo/chameleon5/bin/c5.pl" ],
      [ 'cpanm', "$repo/chameleon5/modules/Chameleon5" ],
      [ 'cpanm', "$repo/chameleon5/modules/Chameleon5-Contrib" ],
    ],
  },
  update => {
    condition => sub { 0 },
    commands  => [
      # git pull in each sub-repo
      [
"find $repo -type d -name .git | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && git pull; done"
      ],
      # CPAN install in the repos
      [
"find $repo -type d -name lib | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && cpanm .; done"
      ],
    ],
  },
  foundation => {
    condition => sub { -e "$site/js/foundation.min.js" },
    commands  => [
      [ 'wget', 'http://foundation.zurb.com/cdn/releases/foundation-5.1.1.zip', '-P', "$ENV{HOME}/Downloads/" ],
      [ 'unzip', "$ENV{HOME}/Downloads/foundation-5.1.1.zip", '-d', "$ENV{HOME}/Downloads/foundation/" ],
      # TODO Make these a single * glob:
      [ 'mv', "$ENV{HOME}/Downloads/foundation/index.html", "$repo/chameleon5/domains/$site/site_root/" ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/css", "$repo/chameleon5/domains/$site/site_root/" ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/img", "$repo/chameleon5/domains/$site/site_root/" ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/js", "$repo/chameleon5/domains/$site/site_root/" ],
    ],
  },
};

# Is the program condition met?
my $condition = $provision->{$switch->{program}}{condition}->() ? 1 : 0;
print "'$switch->{program}' ", ($condition ? 'is' : 'not'), " installed\n";
# If not, run handle the program!
unless ($condition)
{
    for my $cmd ( @{ $provision->{$switch->{program}}{commands} } )
    {
        #warn "CMD: @$cmd\n";
        system(@$cmd) == 0 or warn "system @$cmd failed: $?";
    }
}

