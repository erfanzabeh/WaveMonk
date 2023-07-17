function  ant= AntPost_Index(x,monkey_name)
func = str2func(['new_electrodepinout', monkey_name]);
[array{1}, array{2}] = func('chan');
ant  = sum(sum(array{1} == x));
end
