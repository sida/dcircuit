#!/usr/bin/perl

use strict;
use warnings;
use Circuit;

#NANDクラスは作ってあるけどサンプル用にANDとNOTを組み合わせて作ってみる
my %circuit = (
    'osc1'=>{logic=>'Osc' ,value=>[0,1,0,1]},
    'osc2'=>{logic=>'Osc' ,value=>[0,0,1,1]},
    'and'=>{logic=>'And' ,input=>['osc1','osc2']},
    'or'=>{logic=>'Or' ,input=>['osc1','osc2']},
    'not'=>{logic=>'Not' ,input=>['and']},
);

Circuit::eval_circuit(\%circuit,4,1,'osc1','osc2','and','or','not');
