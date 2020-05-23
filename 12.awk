BEGIN {
    ix = 0;
    tystack[ix] = "";
    indent = 2;
    original="";
    line="";
}

function ptabs() {
    for (j = indent ; j > 0; j -= 1) line = line sprintf(" ");
}

function pcomment(line) {
    printf("%s",line);
    gsub(/[ \t]+/,"",original);
    for(j = length(line); j < 50; j += 1) printf(" ");
    printf " # %s\n", original
}

{
    line="";
    original=$0;
    gsub(/[ \t]+/,"",$0);
    if ($0 ~ /{/) {
	ptabs();
	ix += 1;
	gsub(/{/,"",$0);
	tystack[ix] = $0;
	line = line sprintf("$%s__NewScope", tystack[ix]);
	indent += 2;
    } else if ($0 ~ /}\+/) {
	gsub(/}\+/,"",$0);
	indent -= 2;
	ptabs();
	line = line sprintf("$%s__Output",tystack[ix]);
	printf("%s\n", line);
	line="";
	ptabs();
	line = line sprintf("$%s__AppendFrom_%s", tystack[ix-1], tystack[ix]);
        ix -= 1;
    } else if ($0 ~ /}/) {
	gsub(/}/,"",$0);
	indent -= 2;
	ptabs();
	line = line sprintf("$%s__Output", tystack[ix]);
	ix -= 1;
    } else if ($0 ~ "->\.") {
	gsub(/->\./,"",$0);
	ptabs();
	line = line sprintf("$%s__SetField_%s_from_%s", tystack[ix], tystack[ix+1], tystack[ix+1]);
    } else if ($0 ~ /'/ ) {
        split($0,val,"'");
	ptabs();
	line = line sprintf("$%s__SetEnum_%s_to_%s", tystack[ix], val[2], val[2]);
    } else {
	ptabs();
	gsub(/[ \t]/,"",$0);
	if (length($0) > 0) 
	    line = line sprintf("$%s_%s", tystack[ix], $0);
    }
    pcomment(line);
}


