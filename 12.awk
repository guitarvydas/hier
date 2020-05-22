BEGIN {
    FS = " ";
    ix = 1;
    tystack[ix] = "";
}
/{/ {
    ix += 1;
    tystack[ix] = $2;
    printf "$%s__NewScope\n", tystack[ix];
}
/} +/ {
    printf "$%s__Append\n", tystack[ix];
}
/}/ {
    printf "$%s__Output\n", tystack[ix];
    ix -= 1;
}

