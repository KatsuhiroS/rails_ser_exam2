class ContactMailer < ApplicationMailer
  def contact_mail(blog)
   @blog = blog
   # @current_user ||= User.find_by(id: session[:user_id])
   mail to: @blog.user.email, subject: "お問い合わせの確認メール"
  end
end
