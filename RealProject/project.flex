import java.util.HashSet;
import java.util.Set;
import java.util.*;
import java.util.ArrayList;
import java.util.List;
// import java.io.BufferedReader;
// import java.io.InputStreamReader;

%%
%public
%class lexer
%column
%line
%standalone
// %type STRING
// %type COMMENT


IDENTIFIER = [A-Za-z][A-Za-z0-9]*
OPERATOR = [+\-*/]
SPACE = [ \t]+
KEYWORDS = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
STRING = "\"" [^\"]* "\""
COMMENT = "/*"([^*]|"/*")*"*/"

%{
    List<String> identifiers = new ArrayList<>();
%}

%state INITIAL,COMMENT,STRING

// %eof{
//     if (identifiers.contains(yytext())) {
//         System.out.println("Duplicate identifier: " + yytext());
//     } else {
//         identifiers.add(yytext());
//         System.out.println("new identifier: " + yytext());
//     }
// %eof}

%%
 {KEYWORDS} {
    System.out.println("keyword: " + yytext());
}



 {STRING} {
   System.out.println("String: " +  yytext());
 }


  {IDENTIFIER} 
 {
    // {IDENTIFIER} {identifiers.add(yytext());}
    if (identifiers.contains(yytext())) {
        System.out.println("identifier: " +" " +yytext()+" " +" already in symbol table");
    } else {
        identifiers.add(yytext());
        System.out.println("new identifier: " + yytext());
    }
}

 {OPERATOR} {
    System.out.println("operator: " + yytext());
}

 {SPACE} {
    // Ignore spaces
    // System.out.println("space: " + yytext());
}

 {COMMENT} {
    System.out.print("comment:" + yytext());
 }



<INITIAL> "/*" { 
    yybegin(COMMENT); 
}

<COMMENT> "*/" { 
    yybegin(INITIAL); 
}

<COMMENT>[^\n]* {
    // Ignore characters within a comment
}

\n {
    // Ignore newline characters
}

. {
    System.out.println("Unexpected character: " + yytext());
}

