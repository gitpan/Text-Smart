# $Id: Makefile.PL,v 1.1 2004/05/12 16:44:57 dan Exp $
# -*- perl -*-

use ExtUtils::MakeMaker;

WriteMakefile(
	      NAME => "Text::Smart",
	      VERSION_FROM => 'lib/Text/Smart.pm',

	      dist =>
	      {
	       COMPRESS => 'gzip --force --best',
	      },

	      clean =>
	      {
	       FILES => '*.bak *~',
	      },
	      
	      depend => {
	        Makefile => '$(VERSION_FROM)',
	      },
	      
	      realclean => {
	       FILES => 'Text-Smart-*.tar.gz',
	      },
	     );

package MY;

sub libscan
  {
    my ($self, $path) = @_;
    ($path =~ /\~$/) ? undef : $path;
  }

__END__
