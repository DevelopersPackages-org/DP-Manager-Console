void main(List<String> args) {
  if (args.length>0) {
    for (var arg in args) {
      print(arg);
    }
  }else{
    print("Hello DPManager");
  }
}

class ConsoleCmd{
  String cmdname = "";
}