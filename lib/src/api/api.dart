class ListAPI {
  static const baseHost = "https://it4788.catan.io.vn";

  ///Auth
  static const signup = "$baseHost/signup";
  static const login = "$baseHost/login";
  static const changePassword = "$baseHost/change_password";
  static const logout = "$baseHost/logout";
  static const getVerifyCode = "$baseHost/get_verify_code";
  static const checkVerifyCode = "$baseHost/check_verify_code";
  static const resetPassword = "$baseHost/reset_password";

//Profile
  static const changeProfileAfterSignup =
      "$baseHost/change_profile_after_signup";
  static const getUserInfo = "$baseHost/get_user_info";
  static const setUserInfo = "$baseHost/set_user_info";

//Post
  static const addPost = "$baseHost/add_post";
  static const getListPosts = "$baseHost/get_list_posts";
  static const getPost = "$baseHost/get_post";
  static const deletePost = "$baseHost/delete_post";
  static const editPost = "$baseHost/edit_post";

//Search
  static const search = "$baseHost/search";
  static const searchUsers = "$baseHost/search_user";
  static const getSavedSearch = "$baseHost/get_saved_search";
  static const delSavedSearch = "$baseHost/del_saved_search";

//Friend
  static const getRequestedFriend = "$baseHost/get_requested_friends";
  static const setRequestFriend = "$baseHost/set_request_friend";
  static const setAcceptFriend = "$baseHost/set_accept_friend";
  static const getUserFriend = "$baseHost/get_user_friends";
  static const getSuggestedFriend = "$baseHost/get_suggested_friends";
  static const unfriend = "$baseHost/unfriend";
  static const delRequestFriend = "$baseHost/del_request_friend";

//Block
  static const getListBlocks = "$baseHost/get_list_blocks";
  static const setBlock = "$baseHost/set_block";
  static const unBlock = "$baseHost/unblock";

//Settings

//Comment
  static const feel = "$baseHost/feel";
  static const getListFeels = "$baseHost/get_list_feels";
  static const getMarkComment = "$baseHost/get_mark_comment";
  static const setMarkComment = "$baseHost/set_mark_comment";
}
