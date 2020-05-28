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
    printf("%s\n",line);
}

{
    line="";
    original=$0;
    gsub(/[ \t]+/,"",$0);
    if ($0 ~ /\[/) {
	ptabs();
	ix += 1;
	tystack[ix] = "%map";
	line = line "NewScope(\"%map\")";
	indent += 2;
    } else if ($0 ~ /{/) {
	ptabs();
	ix += 1;
	gsub(/{/,"",$0);
	tystack[ix] = $0;
	line = line sprintf("NewScope(\"%s\")", tystack[ix]);
	indent += 2;
    } else if ($0 ~ /}\+/) {
	gsub(/}\+/,"",$0);
	indent -= 2;
	ptabs();
	line = line sprintf("Output(\"%s\")",tystack[ix]);
	printf("%s\n", line);
	line="";
	ptabs();
	line = line sprintf("AppendFrom(\"%s\",\"%s\")", tystack[ix-1], tystack[ix]);
        ix -= 1;
    } else if ($0 ~ /]/) {
	gsub(/}/,"",$0);
	indent -= 2;
	ptabs();
	line = line "Output(\"%map\")";
	ix -= 1;
    } else if ($0 ~ /}/) {
	gsub(/}/,"",$0);
	indent -= 2;
	ptabs();
	line = line sprintf("Output(\"%s\")", tystack[ix]);
	ix -= 1;
    } else if ($0 ~ "->\.") {
	gsub(/->\./,"",$0);
	ptabs();
	line = line sprintf("SetField(\"%s\",\"%s\",\"%s\")", tystack[ix], tystack[ix+1], tystack[ix+1]);
    } else if ($0 ~ /'/ ) {
        split($0,val,"'");
	ptabs();
	line = line sprintf("SetEnum(\"%s\",\"%s\",\"%s\")", tystack[ix], val[2], val[2]);
    } else {
	ptabs();
	gsub(/[ \t]/,"",$0);
	if (length($0) > 0) 
	    line = line sprintf("CallExternal(\"%s\",\"%s\")", tystack[ix], $0);
    }
    pcomment(line);
}



