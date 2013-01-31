#!/usr/bin/perl

use strict;
use warnings;
use Circuit;

my %circuit = (
    'osc1'=>{logic=>'Osc' ,value=>[0,0,1,0,0,0]},
    'osc2'=>{logic=>'Osc' ,value=>[1,0,0,0,0,0]},
    'not1'=>{logic=>'Not' ,input=>['osc1']},
    'not2'=>{logic=>'Not' ,input=>['osc2']},
    'nand1'=>{logic=>'Nand' ,input=>['not1','nand2']},
    'nand2'=>{logic=>'Nand' ,input=>['not2','nand1']},
);

Circuit::eval_circuit(\%circuit,6,1,'osc1','osc2','nand1','nand2');
