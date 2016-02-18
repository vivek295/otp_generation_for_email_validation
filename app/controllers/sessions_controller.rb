class SessionsController < Devise::SessionsController
  def new
  	@User=User.new
  end

  def create
    @user=User.find_by(email: params[:user][:email])
    puts params[:user][:email]
    if @user && @user.authenticated?(params[:user][:password])
      flash[:success]="Logged In Successfully"
      log_in @user
      redirect_to root_path
    else
      flash[:danger]="Invalid Email/Password combination"
      redirect_to root_path
    end
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_path
  end

  def verify_signed_out_user
    logged_in?
  end

end
