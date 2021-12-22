function  [X,Y,ANT]= chan_position(x,monkey_name)
func = str2func(['new_electrodepinout', monkey_name]);
[array{1}, array{2}] = func('chan');
ant  = sum(sum(array{1} == x));
if ant==1
    [X,Y] = find(array{1} == x);
    ANT = 1;
else
    [X,Y] = find(array{2} == x);
    ANT = 2;
end
