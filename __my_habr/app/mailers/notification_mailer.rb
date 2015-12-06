class NotificationMailer < ApplicationMailer

  def comment_notification(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: 'Новый ответ')

  end


  def comment_subscription_notification(post, comment)
    @post = post
    @comment = comment
    @post.subscribers.each do |user|
      @user = user
      mail(to: user.email, subject: 'Новый ответ')
    end
  end

  def moderation_notification(post)
    @user = post.user
    @post = post

    mail(to: @user.email, subject: 'Итог модерации')

  end
end
