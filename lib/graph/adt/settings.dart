class Settings {
  bool allowLoops;
  bool isMultiGraph;
  bool isDigraph;
  bool isCyclic;

  Settings(
      {this.allowLoops = false,
      this.isDigraph = true,
      this.isMultiGraph = true,
      this.isCyclic = true});
}
