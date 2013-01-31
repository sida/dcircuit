package Circuit;

use strict;
use warnings;
use Logic;

sub eval_circuit{
    my $def = shift;
    my $t = shift;
    my $n = shift;
    my @result = @_;
    
    my $c = create_circuit($def);
    go_circuit($c ,$t ,$n ,@result);
}

sub create_circuit{
    my $circuit_def = shift;

    #オブジェクト生成
    my %circuit_obj_list = ();
    foreach my $name(keys %$circuit_def){
	my $attr = $circuit_def->{$name};
	my $logic = ($attr->{logic})->new($attr->{value});
	$circuit_obj_list{$name} = $logic;
    }

    #オブジェクト間の関連付け
    foreach my $name(keys %$circuit_def){
	my $logic = $circuit_obj_list{$name};
	
	my $arg = $circuit_def->{$name}->{input};
	next unless (defined($arg));
	my @arg_obj=();
	foreach my $arg_obj_name (@$arg){
	push (@arg_obj,$circuit_obj_list{$arg_obj_name});
	}
	$logic->set_in(@arg_obj);
    }
    return \%circuit_obj_list;
}

sub go_circuit{
    my $list = shift;
    my $t = shift;#1周期間隔
    my $n = shift;#繰り返し回数
    my $num = scalar(keys(%$list));

    print join(',',@_)."\n";
    for (my $jj=0;$jj<$n;$jj++){
	for (my $time_cnt=0;$time_cnt<$t;$time_cnt++){
	    for (my $ii=0;$ii<$num;$ii++){
		vcalc($time_cnt,values(%$list));#とりあえず回路数分回しておけ
	    }
	    print_result($list,@_);
	}
    }
}

sub vcalc{
    my $t = shift;
    foreach my $node(@_){
	$node->calc($t);
    }
}

sub print_result{
    my $obj = shift;
    my @res = ();
    foreach my $name(@_){
	push (@res,$obj->{$name}->out());
    }
    print join(',',@res)."\n";
}

1;
