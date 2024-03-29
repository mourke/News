class HighestRatedComparator implements Comparator<Story> {

  @Override public int compare(Story lhs, Story rhs) {
    return (rhs.score() - lhs.score());
  }
}
