BEGIN {
    ix = 0;
    tystack[ix] = "";
    indent = 2;
    original="";
}

function ptabs() {
    for (j = indent ; j > 0; j -= 1) printf " "
}

function pcomment() {
    gsub(/[ \t]+/,"",original);
    printf "\t# %s\n", original
}

{
    original=$0;
    gsub(/[ \t]+/,"",$0);
    if ($0 ~ /{/) {
	ptabs();
	ix += 1;
	gsub(/{/,"",$0);
	tystack[ix] = $0;
	printf "$%s__NewScope", tystack[ix];
	indent += 2;
    } else if ($0 ~ /}\+/) {
	gsub(/}\+/,"",$0);
	ptabs();
	printf "$%s__Output\n", tystack[ix];
	ptabs();
	printf "$%s__AppendFrom_%s", tystack[ix-1], tystack[ix];
        ix -= 1;
	indent -= 2;
    } else if ($0 ~ /}/) {
	gsub(/}/,"",$0);
	indent -= 2;
	ptabs();
	printf "$%s__Output", tystack[ix];
	ix -= 1;
    } else if ($0 ~ "->\.") {
	gsub(/->\./,"",$0);
	ptabs();
	printf "$%s__SetField_%s_from_%s", tystack[ix], tystack[ix+1], tystack[ix+1];
    } else if ($0 ~ /'/ ) {
        split($0,val,"'");
	ptabs();
	printf "$%s__SetEnum_%s_to_%s", tystack[ix], val[2], val[2];
    } else {
	ptabs();
	gsub(/[ \t]/,"",$0);
	if (length($0) > 0) 
	    printf "$%s_%s", tystack[ix], $0;
    }
    pcomment();
}


