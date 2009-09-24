#!/usr/bin/perl

=head1 NAME

leaks.pl - Displays the errors reported by valgrind

=head1 SYNOPSIS

leaks.pl [OPTION]... FILE

  -h, --help        displays this help mesage
  -a, --all         show all errors
  -d, --dir=folder  the folder having the project's source files

=cut

use strict;
use warnings;
use open ':std', ':utf8';

use XML::LibXML;
use FindBin;
use File::Spec;
use Cwd 'realpath';
use Getopt::Long qw(:config auto_help);


exit main();


sub main {
  my $show_all = 0;
	my $folder = "$FindBin::Bin/..";
  GetOptions(
    'all|a'        => \$show_all,
    'dir|folder=s' => \$folder,
  );
	die "Usage: file\n" unless @ARGV;
	my ($file) = @ARGV;
	
  my $xpath;
  if ($show_all) {
  	$xpath = "//error";
  }
  else {
  	$folder = realpath($folder);
		$xpath = "//error[ .//stack/frame/dir [starts-with(., '$folder') ] ]";
  }
	
	my $parser = XML::LibXML->new();
	my $document = $parser->parse_file($file);
	foreach my $errorNode ($document->findnodes($xpath)) {
	
		# Pango has a leak in _clutter_context_create_pango_context()
		next if $errorNode->findvalue('.//fn [. = "_clutter_context_create_pango_context"]');

		my $what = get_tag($errorNode, 'what');
		print "$what\n";
		
		foreach my $frameNode ($errorNode->findnodes('stack/frame')) {
			if (my $function = get_tag($frameNode, 'fn')) {
				
				my $where;
				
				if (my $file = get_tag($frameNode, 'file')) {
					my $line = get_tag($frameNode, 'line');
					$where = "$file:$line";
				}
				else {
					my $obj = get_tag($frameNode, 'obj');
					$where = "in $obj";
				}
				
				print "  $function ($where)\n";
			}
			else {
				print "  (within ", get_tag($frameNode, 'obj'), ")\n";
			}
			
		}
		print "\n\n";
		
	}
	
	return 0;
}


sub get_tag {
	my ($parent, $name) = @_;
	my ($node) = $parent->getChildrenByTagName($name);
	return $node ? $node->textContent : '';
}
