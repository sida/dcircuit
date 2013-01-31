package Osc;

sub new{
    my $class = shift;
    my $wave_form = shift;
    bless{
	wave=>$wave_form,
	val=>-1,#-1は未定
    },$class;
}

sub out{
    my $self = shift;
    return $self->{val};
}

sub set_in{
    my $self = shift;
}

sub calc{
    my $self = shift;
    my $t = shift;
    $self->{val} = $self->{wave}->[$t];
}

package Not;

sub new{
    my $class = shift;
    bless{
	input=>\@_,
	val=>-1,#-1は未定
    },$class;
}

sub out{
    my $self = shift;
    return $self->{val};
}

sub set_in{
    my $self = shift;
    $self->{input}=\@_;
}

sub calc{
    my $self = shift;
    my $t = shift;
    my $in = $self->{input}->[0];
    my $i = $in->out($t);
    if ($i==-1) {$self->{val} = -1;}
    $self->{val} = !$i+0;
}

package Fixed;

sub new{
    my $class = shift;
    bless{
	val=>shift,
    },$class;
}

sub out{
    my $self = shift;
    return $self->{val};
}

sub set_in{
    my $self = shift;
}

sub calc{
    my $self = shift;
    my $t = shift;
    $self->{val} = $self->{val};
}

package And;

sub new{
    my $class = shift;
    bless{
	input=>\@_,
	val=>-1,#-1は未定
    },$class;
}

sub out{
    my $self = shift;
    return $self->{val};
}

sub set_in{
    my $self = shift;
    $self->{input}=\@_;
}

sub calc{
    my $self = shift;
    my $t = shift;
    my $in = $self->{input};
    my $l_cnt = 0;
    my $h_cnt = 0;
    my $non_cnt = 0;
    foreach my $node(@$in){
	my $i = $node->out();
	if ($i == 0){$l_cnt++;}
	elsif ($i == 1){$h_cnt++;}
	elsif ($i == -1){$non_cnt++;}
    }
    if (($l_cnt == 0)&&($non_cnt==0)) {$self->{val} = 1;}
    elsif ($l_cnt > 0){$self->{val} = 0;}
    else {$self->{val} = -1;}
}

package Nand;

sub new{
    my $class = shift;
    bless{
	input=>\@_,
	val=>-1,#-1は未定
    },$class;
}

sub out{
    my $self = shift;
    return $self->{val};
}

sub set_in{
    my $self = shift;
    $self->{input}=\@_;
}

sub calc{
    my $self = shift;
    my $t = shift;
    my $in = $self->{input};
    my $l_cnt = 0;
    my $h_cnt = 0;
    my $non_cnt = 0;
    foreach my $node(@$in){
	my $i = $node->out();
	if ($i == 0){$l_cnt++;}
	elsif ($i == 1){$h_cnt++;}
	elsif ($i == -1){$non_cnt++;}
    }
    if (($l_cnt == 0)&&($non_cnt==0)) {$self->{val} = 0;}
    elsif ($l_cnt>0){$self->{val} = 1;}
    else {$self->{val} = -1;}
}

package Or;

sub new{
    my $class = shift;
    bless{
	input=>\@_,
	val=>-1,#-1は未定
    },$class;
}

sub out{
    my $self = shift;
    return $self->{val};
}

sub set_in{
    my $self = shift;
    $self->{input}=\@_;
}

sub calc{
    my $self = shift;
    my $t = shift;
    my $in = $self->{input};
    my $l_cnt = 0;
    my $h_cnt = 0;
    my $non_cnt = 0;
    foreach my $node(@$in){
	my $i = $node->out();
	if ($i == 0){$l_cnt++;}
	elsif ($i == 1){$h_cnt++;}
	elsif ($i == -1){$non_cnt++;}
    }
    if ($h_cnt > 0){$self->{val} = 1;}
    elsif (($h_cnt == 0)&&($non_cnt==0)) {$self->{val} = 0;}
    else {$self->{val} = -1;}
}


1;