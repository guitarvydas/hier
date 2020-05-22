BEGIN {
    ix = 0;
    ixhighwater = ix;
    tystack[ix] = "";
    indent = 2;
}

{
    if ($0 ~ /{/) {
	indent += 2;
	for (j = indent; j > 0; j -=1) printf " "
	ix += 1;
	ixhighwater = ix;
	tystack[ix] = $2;
	printf "$%s__NewScope\n", tystack[ix];
    } else if ($0 ~ /} +/) {
	for (j = indent; j > 0; j -=1) printf " "
	printf "+++ %s\n", tystack[ix];
    } else if ($0 ~ /}/) {
	ix -= 1;
	for (j = indent; j > 0; j -=1) printf " "
	indent -= 2;
	printf "$%s__Output\n", tystack[ix];
    } else {
	print
    }
}

END { for (j = 1 ; j <= ixhighwater; j += 1) printf ("%s ",tystack[j]); print "" }

