typedef bool Comparator<T extends Comparable>(T left, T right);
bool ascendingFn<T extends Comparable>(a, b) => a.compareTo(b) <= 0;

void swap<T extends Comparable>(List<T> list, int i, int j) {
  T temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
