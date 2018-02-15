#!/usr/bin/perl

#  IPspeak

# Andy S-C
# 18-May-13
# 15-Oct-16 - made more "human" ... ten dot nought dot one nine three dot seventeen

# this is the order we check the interfaces
@interfaces = ("eth0", "wlan0");


%names = ("eth0"=>"ethernet",
          "wlan0"=>"wireless");

# give it a chance to get an IP address at boot-up
sleep 10;


while (1)
{
  $found = 0;

  for $interface (@interfaces)
  {
    print "$interface -> $names{$interface}\n";

	$IP = `ifconfig $interface | grep 'inet'`;
		$text = $names{$interface} . " address ";

		if ($IP =~ /inet (.*?) /)
		{
		  $IP = $1;
      		  $text .= &render_address($IP);
		  &speak($text);
		  $found=1;
		}
  }

  if (!$found)
  {
    $text = "no IP address";
    &speak($text);
  }

  sleep 30;
}


sub speak
{
  my ($text) = @_;
  print "'$text'\n";
  system("espeak -s150 -g30 '$text' --stdout > /tmp/ip.wav | mplayer /tmp/ip.wav");
}


sub render_address
{
  my ($IP) = @_;
  my @octets = split(/\./,$IP);
  my @address;

  foreach $octet (@octets)  
  {
    push(@address, &render_octet($octet));
  }
  my $text = join(" dot ",@address);
  return $text;
}


sub render_octet
{
  my ($number) = @_;
  
  if ($number == 0)
  {
    $result = "nought";
  }
  elsif ($number < 100)
  {
    $result = $number;
  }
  else
  {
    # split into digits
    $result = join(" ", split(//,$number));
  }

  return $result;
}
