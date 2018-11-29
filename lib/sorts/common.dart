typedef bool Comparator<T extends Comparable>(T left, T right);
bool ascendingFn<T extends Comparable>(a, b) => a.compareTo(b) <= 0;
