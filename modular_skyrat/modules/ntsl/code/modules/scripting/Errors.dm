/*
	File: Errors
*/
/*
	Class: scriptError
	An error scanning or parsing the source code.
*/
/scriptError
	var
/*
	Var: message
	A message describing the problem.
*/
		message
/scriptError/New(msg=null)
	if(msg)message=msg

/scriptError/BadToken
	message="Unexpected token: "
	var/token/token
/scriptError/BadToken/New(token/t)
	token=t
	if(t&&t.line) message="[t.line]: [message]"
	if(istype(t))message+="[t.value]"
	else message+="[t]"

/scriptError/InvalidID
	parent_type=/scriptError/BadToken
	message="Invalid identifier name: "

/scriptError/ReservedWord
	parent_type=/scriptError/BadToken
	message="Identifer using reserved word: "

/scriptError/BadNumber
	parent_type=/scriptError/BadToken
	message = "Bad number: "

/scriptError/BadReturn
	var/token/token
	message = "Unexpected return statement outside of a function."
/scriptError/BadReturn/New(token/t)
	src.token=t

/scriptError/EndOfFile
	message = "Unexpected end of file."

/scriptError/ExpectedToken
	message="Expected: "
/scriptError/ExpectedToken/New(id, token/T)
	if(T)
		message = "[T.line ? T.line : "???"]: [message]'[id]'. Found '[T.value]'."
	else
		message = "???: [message]'[id]'. Token did not exist!"

/scriptError/UnterminatedComment
	message="Unterminated multi-line comment statement: expected */"

/scriptError/DuplicateFunction
/scriptError/DuplicateFunction/New(name, token/t)
	message="Function '[name]' defined twice."

/scriptError/ParameterFunction
	message = "You cannot use a function inside a parameter."

/scriptError/ParameterFunction/New(token/t)
	var/line = "???"
	if(t)
		line = t.line
	message = "[line]: [message]"

/scriptError/InvalidAssignment
	message="Left side of assignment cannot be assigned to."

/scriptError/OutdatedScript
	message = "Your script looks like it was for an older version of NTSL! Your script may not work as intended. See documentation for new syntax and API."

/*
	Class: runtimeError
	An error thrown by the interpreter in running the script.
*/
/runtimeError
	var
		name
/*
	Var: message
	A basic description as to what went wrong.
*/
		message
		scope/scope
		token/token

/*
	Proc: ToString
	Returns a description of the error suitable for showing to the user.
*/
/runtimeError/proc/ToString()
	. = "[name]: [message]"
	if(!scope) return
	var/last_line
	var/last_col
	if(token)
		last_line = token.line
		last_col = token.column
	var/scope/cur_scope = scope
	while(cur_scope)
		if(cur_scope.function)
			. += "\n\tat [cur_scope.function.func_name]([last_line]:[last_col])"
			if(cur_scope.call_node && cur_scope.call_node.token)
				last_line = cur_scope.call_node.token.line
				last_col = cur_scope.call_node.token.column
			else
				last_line = null
				last_col = null
		cur_scope = cur_scope.parent
	if(last_line)
		. += "\n\tat \[global]([last_line]:[last_col])"
	else
		. += "\n\tat \[internal]"

/runtimeError/TypeMismatch
	name="TypeMismatchError"
/runtimeError/TypeMismatch/New(op, a, b)
	if(isnull(a))
		a = "NULL"
	if(isnull(b))
		b = "NULL"
	message="Type mismatch: '[a]' [op] '[b]'"

/runtimeError/UnexpectedReturn
	name="UnexpectedReturnError"
	message="Unexpected return statement."

/runtimeError/UnknownInstruction
	name="UnknownInstructionError"
/runtimeError/UnknownInstruction/New(node/op)
	message="Unknown instruction type '[op.type]'. This may be due to incompatible compiler and interpreter versions or a lack of implementation."

/runtimeError/UndefinedVariable
	name="UndefinedVariableError"
/runtimeError/UndefinedVariable/New(variable)
	message="Variable '[variable]' has not been declared."

/runtimeError/IndexOutOfRange
	name="IndexOutOfRangeError"
/runtimeError/IndexOutOfRange/New(obj, idx)
	message="Index [obj]\[[idx]] is out of range."

/runtimeError/UndefinedFunction
	name="UndefinedFunctionError"
/runtimeError/UndefinedFunction/New(function)
	message="Function '[function]()' has not been defined."

/runtimeError/DuplicateVariableDeclaration
	name="DuplicateVariableError"
/runtimeError/DuplicateVariableDeclaration/New(variable)
	message="Variable '[variable]' was already declared."

/runtimeError/IterationLimitReached
	name="MaxIterationError"
	message="A loop has reached its maximum number of iterations."

/runtimeError/RecursionLimitReached
	name="MaxRecursionError"
	message="The maximum amount of recursion has been reached."

/runtimeError/DivisionByZero
	name="DivideByZeroError"
	message="Division by zero (or a NULL value) attempted."

/runtimeError/InvalidAssignment
	message="Left side of assignment cannot be assigned to."

/runtimeError/MaxCPU
	name="MaxComputationalUse"
/runtimeError/MaxCPU/New(maxcycles)
	message="Maximum amount of computational cycles reached (>= [maxcycles])."

/runtimeError/Internal
	name="InternalError"
/runtimeError/Internal/New(exception/E)
	message = E.name
