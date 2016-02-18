class VerificationsController < ApplicationController
  attr_accessor :user

  def edit
    @user=User.find_by(email: params[:email])
  end

  def update 
    @user=User.find_by(email: params[:email])
    @user=User.find_by(id: params[:id]) unless @user

    if @user && !@user.verified && (@user.otp).to_i==(params[:user][:otp]).to_i
      @user.activate
      flash[:success]="Account verified"
      log_in @user
      redirect_to root_path
    else
      flash[:success]="Invalid OTP"
      redirect_to root_path
    end
  end
end