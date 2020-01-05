  
class Util {
  static String getFriendId(String userId1, String userId2) {
    if (userId1.compareTo(userId2) == -1) {
      return userId1 + userId2;
    }
    return userId2 + userId1;
  }
}