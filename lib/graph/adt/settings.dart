/// Settings module for Graphs
class Settings {
  /// Does the implementing graph will allow loops?
  bool allowLoops;

  /// Is the implementing graph a multigraph?
  bool isMultiGraph;

  /// Is the implementing a digraph?
  bool isDigraph;

  /// Is the implementing grpha cyclic?
  bool isCyclic;

  /// Constructor
  Settings(
      {this.allowLoops = false,
      this.isDigraph = true,
      this.isMultiGraph = true,
      this.isCyclic = true});
}
