100 REM TEST
200 PS = 664
300 FOR LP = 0 TO 27
400 READ A% : POKE PS+LP,A%: NEXT LP
500 SYS PS
600 END 
700 DATA 169,1,162,8,160,1,32,186
800 DATA 255,169,2,162,178,160,2,32
900 DATA 189,255,169,0,32,213,255,76
1000 DATA 0,18,84,83