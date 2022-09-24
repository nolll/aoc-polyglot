use strict;
use warnings;

use File::Slurp;

my %registers1 = run(0);
my $result1 = $registers1{"b"};
print "$result1\n";

my %registers2 = run(1);
my $result2 = $registers2{"b"};
print "$result2\n";

sub readLines{
    my $content = read_file("input.txt");
    return split("\n", $content);
}

sub run {
    my ($a) = @_;
    my %registers = ("a" => $a, "b" => 0);

    my @instructions = readLines();
    my $pointer = 0;
    my $counter = 0;

    while ( $pointer >= 0 && $pointer < scalar(@instructions)) {
        my $instruction = $instructions[$pointer];
        my @parts = split(" ", $instruction);
        my $name = $parts[0];
        my $register;
        
        if ($name eq "hlf")
        {
            $register = substr($parts[1], 0, 1);
            $registers{$register} = $registers{$register} / 2;
            $pointer++;
        }

        elsif ($name eq "tpl")
        {
            $register = substr($parts[1], 0, 1);
            $registers{$register} = $registers{$register} * 3;
            $pointer++;
        }

        elsif ($name eq "inc")
        {
            $register = substr($parts[1], 0, 1);
            $registers{$register} = $registers{$register} + 1;
            $pointer++;
        }

        elsif ($name eq "jmp")
        {
            my $offset = $parts[1];
            $pointer += $offset;
        }

        elsif ($name eq "jie")
        {
            $register = substr($parts[1], 0, 1);
            my $offset = $parts[2];

            if ($registers{$register} % 2 == 0)
            {
                $pointer += $offset;
            }
            else
            {
                $pointer++;
            }
        }

        elsif ($name eq "jio")
        {
            $register = substr($parts[1], 0, 1);
            my $offset = $parts[2];

            if ($registers{$register} == 1)
            {
                $pointer += $offset;
            }
            else
            {
                $pointer++;
            }
        }

        $counter++;
    }

    return %registers;
}
