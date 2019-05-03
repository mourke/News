class CommentNumberComparator implements Comparator<Story> {

  @Override public int compare(Story lhs, Story rhs) {
    return (rhs.numberOfComments() - lhs.numberOfComments());
  }
}
