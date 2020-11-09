syn match	cFunction	/\w\+\s*(/me=e-1,he=e-1
syn match	cOperator	"?\|+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"

hi def link cFunction	Function
hi def link cOperator	Operator
