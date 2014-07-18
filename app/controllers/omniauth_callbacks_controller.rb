class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # for whichever provider you are implementing you just make an action for that.
  def twitter
    @user = User.find_or_create_by_omniauth(auth_hash)

    if @user.persisted?
      sign_in @user
      redirect_to root_path, notice: 'User now signed in with twitter'
    else
      redirect_to root_path, alert: 'Could not sign in'
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end
