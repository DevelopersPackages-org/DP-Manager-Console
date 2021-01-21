import 'package:args/args.dart';

ArgResults argResults;

void main(List<String> args) {
  ArgParser parserB = ArgParser(allowTrailingOptions: true);
  final List<ConsoleCmd> cmds = makeCmds();
  final Argperser parser = addArgCmd(cmds, parser);
  argResults = parser.parse(arguments);
  if (args.length>0) {
    for (String arg in args) {
      print(arg);
    }
  }
  else{
    print("Hello DPManager");
  }
}
ArgParser addArgCmd(List<ConSoleCmd> cmds, ArgParser parser){
  return parser;
}
List<ConsoleCmd> makeCmds(){
  List<ConsoleCmd> cmds = List();
  cmds.add(Consolecmd());
  
  return cmds;
}
class ConsoleCmd{
  String cmdname = "";
  ArgParser parser = ArgParser(allowTrailingOptions: true);

  ConsoleCmd(String name){
    this.cmdname = name;
  }

  String get getName => cmdname;
  ArgParser get getChild => parser;

  void addFlag(Siring name,String abbr,bool defaults,String help){
    this.parser.addFlag(name, abbr:abbr, defaultsTo: defaults);
  }
  void addOpt(){
    this.parser
  }

}
class ConsoleCmd{
  String flgname = "";

  ConsoleCmd(){

  }

}