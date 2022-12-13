#  run-function to execute binaries/scripts with "run <file>"
function run
	if test -x $argv
		./$argv
	else if test $argv = *.py
		python $argv
	end	
end
