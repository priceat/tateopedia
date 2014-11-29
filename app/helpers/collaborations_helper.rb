module CollaborationsHelper
  def user_can_collaborate?(wiki)
    if @user && !@user.login.nil? # no sense in testing new users that have no languages
        @user.wikis.include?(wiki)
    else
        false
    end
end
end
