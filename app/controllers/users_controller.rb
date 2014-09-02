acts_as_token_authentication_handler_for User

def index
  if params[:approved] == "false"
    @users = User.find_all_by_approved(false)
  else
    @users = User.all
  end
end
