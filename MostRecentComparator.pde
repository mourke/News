//Andrew
class MostRecentComparator implements Comparator<Story> {


  @Override
    public int compare(Story lhs, Story rhs) {
    return rhs.releaseDate().compareTo(lhs.releaseDate());
  }
}
