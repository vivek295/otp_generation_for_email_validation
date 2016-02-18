class RegistrationsController < Devise::RegistrationsController

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    otp=(0...6).map{|i| rand ((i==0 ? 1 :0)..9)}.join.to_i
    @user.otp=otp
    if @user.save
      UserMailer.otp_mail(@user).deliver_now
      flash[:success]="Verify Mail"
      redirect_to edit_verification_url(@user.id)
    else
      render 'new'
    end
    
  end

  def edit
    @user=User.find_by(id: session[:user_id])
    puts "Hello"
    if(@user.verified)
      @user
    else 
      flash[:danger]="Please Verify your Account"
      redirect_to edit_verification_url(session[:user_id])
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      flash[:danger] = @user.errors.messages
      render 'edit'
    end
  end

  def index

  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def authenticate_scope!
      logged_in?
  end
end
