class UserMailer < ApplicationMailer
	def otp_mail(user)
	  @user = user
	  mail(to: @user.email, subject: ' OTP ')
	end
end
