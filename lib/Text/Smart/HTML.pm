# -*- perl -*-
#
# Text::Smart::HTML by Daniel Berrange <dan@berrange.com>
#
# Copyright (C) 2000-2004 Daniel P. Berrange <dan@berrange.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# $Id: HTML.pm,v 1.1 2004/05/12 16:44:57 dan Exp $

=pod

=head1 NAME

Text::Smart::HTML - foo bar

=head1 SYNOPSIS

  use Text::Smart::HTML;
  
  my $markup = Text::Smart::HTML->new(%params);

=head1 DESCRIPTION

=head1 METHODS

=over 4

=cut

package Text::Smart::HTML;

use strict;
use Carp qw(confess);

use Text::Smart;

use vars qw(@ISA);

@ISA = qw(Text::Smart);


sub new
  {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(entities => {
      fraction12 => "&frac12;",
      fraction14 => "&frac14;",
      fraction34 => "&frac34;",
      copyright => "&copy;",
      registered => "&reg;",
      trademark => "<sup>TM</sup>",
    });
    my %params = @_;
    
    $self->{target} = exists $params{target} ? $params{target} : "_self";
    
    bless $self, $class;
    
    return $self;
  }


sub generate_divider
  {
    my $self = shift;
    
    return "<hr>\n";
  }


sub generate_itemize
  {
    my $self = shift;   
    my @items = @_;
    
    return "<ul>\n" . (join("\n", map { "<li>$_</li>\n" } @items)) . "</ul>\n";
  }


sub generate_enumeration
  {
    my $self = shift;   
    my @items = @_;
    
    return "<ol>\n" . (join("\n", map { "<li>$_</li>\n" } @items)) . "</ol>\n";
  }


sub generate_heading
  {
      my $self = shift;
      local $_ = $_[0];
      my $level = $_[1];

      my %levels = (
		    "title" => "h1",
		    "subtitle" => "h2",
		    "section" => "h3",
		    "subsection" => "h4",
		    "subsubsection" => "h5",
		    "paragraph" => "h6",
		    );

      return "<" . $levels{$level} . ">$_</" . $levels{$level} . ">\n";
  }

sub generate_paragraph
  {
    my $self = shift;   
    local $_ = $_[0];
    
    return "<p>$_</p>\n";
  }


sub generate_bold
  {
    my $self = shift;   
    local $_ = $_[0];
    
    return "<strong>$_</strong>";
  }


sub generate_italic
  {
    my $self = shift;   
    local $_ = $_[0];
    
    return "<em>$_</em>";
  }


sub generate_monospace
  {
    my $self = shift;   
    local $_ = $_[0];
    
    return "<code>$_</code>";
  }


sub generate_link
  {
    my $self = shift;
    my $url = shift;   
    local $_ = $_[0];
    
    return "<a target=\"$self->{target}\" href=\"$url\">$_</a>";
  }
  

1 # So that the require or use succeeds.

__END__

=back 4

=head1 AUTHORS

Daniel Berrange <dan@berrange.com>

=head1 COPYRIGHT

Copyright (C) 2000-2004 Daniel P. Berrange <dan@berrange.com>

=head1 SEE ALSO

L<perl(1)>

=cut
