class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    @user = current_user
    super do
      if request.format.json?
        render :json => {
            'status' => 'ok',
            #'csrf_token' => form_authenticity_token,
            'result' => {
                'user' => {
                    'id' => @user.id,
                    'name' => @user.name,
                    'email' => @user.email
                }
            }
        } and return
      end
    end
  end

  def destroy
    super do
      if request.format.json?
        render :json => {
            'csrf_param' => request_forgery_protection_token,
            'csrf_token' => form_authenticity_token
        }
        return
      end
    end
  end
end