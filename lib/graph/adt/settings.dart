/// Settings module for Graphs
class Settings {
  /// Does the implementing graph will allow loops?
  bool allowLoops;

  /// Is the implementing a digraph?
  bool isDigraph;

  /// Constructor
  Settings({this.allowLoops = false, this.isDigraph = true});
}
