BEGIN {
    ix = 0;
    tystack[ix] = "";
    indent = 2;
}

function ptabs() {
    for (j = indent ; j > 0; j -= 1) printf " "
}

{
    if ($0 ~ /{/) {
	ptabs();
	ix += 1;
	tystack[ix] = $2;
	printf "$%s__NewScope\n", tystack[ix];
	indent += 2;
    } else if ($0 ~ /} +/) {
	ptabs();
	printf "$%s__Output\n", tystack[ix];
	for (j = indent; j > 2; j -=1) printf " "
	printf "$%s__AppendFrom_%s\n", tystack[ix-1], tystack[ix];
        ix -= 1;
	indent -= 2;
    } else if ($0 ~ /}/) {
	indent -= 2;
	ptabs();
	printf "$%s__Output\n", tystack[ix];
	ix -= 1;
    } else if ($0 ~ "->") {
	ptabs();
	printf "$%s__SetField_%s_from_%s\n", tystack[ix], tystack[ix+1], tystack[ix+1];
    } else if ($0 ~ /'/ ) {
        split($0,val,"'");
	ptabs();
	printf "$%s__SetEnum_%s_to_%s\n", tystack[ix], val[2], val[2];
    } else {
	print
    }
}


