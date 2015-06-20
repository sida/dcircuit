デジタル回路シミュレータ（のようなもの）

・ファイル
　Logic.pm　論理回路の定義  
　Circuit.pm　回路の定義の取り込みとシミュレート  
　sample1.pl　簡単なデモサンプル  
　sample-rs-flipflop.pl　RSフリップフロップのデモ  

・用意してある回路
　AND,OR,NOT  
　オシレーター  

・使い方
　*回路定義
　例)  
　```
　my %circuit = (
    'osc1'=>{logic=>'Osc' ,value=>[0,1,0,1]},
    'osc2'=>{logic=>'Osc' ,value=>[0,0,1,1]},
    'and'=>{logic=>'And' ,input=>['osc1','osc2']},
    'or'=>{logic=>'Or' ,input=>['osc1','osc2']},
    'not'=>{logic=>'Not' ,input=>['and']},
  );
  ```
　　\'osc1'=>{....} : キーが論理回路に任意につける名前になる  
　　logic=>'Osc' : 論理回路はオシレーターを使う(他にはAnd,Or,Not,Nand がある)  
　　value=>[0,1,0,1] : オシレーターの場合に指定できる。オシレータが出力する波形の1周期のパターン  
　　input=>['osc1','osc2'] : 入力の指定、osc1とosc2の出力を入力としている  

　*回路のシミュレート
　Circuit::eval_circuit($circuit,$wavecnt,$loopnum,'logicname','logicname',...);  
　引数:  
　　$circuit 回路の定義  
　　$wavecnt 1周期の間隔(オシレータに指定した波形の長さ)  
　　$loopnum 繰り替え回数(オシレータの出力を何回繰り返すか)  
　　'logicname','logicname'... 結果を表示したい論理回路の名前  
