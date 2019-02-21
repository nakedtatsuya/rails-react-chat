class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    super do
      if request.format.json?
        render :json => {
            'status' => 'ok',
            #'csrf_token' => form_authenticity_token,
            'result' => {
                'user' => {
                    'id' => @user.id,
                    'email' => @user.email
                }
            }
        } and return
      end
    end
  end
end