class FavoriteMailer < ApplicationMailer
  default from: "emikod@mac.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@sheltered-hollows-76187>"
    headers["In-Reply_To"] = "<post/#{post.id}@sheltered-hollows-76187>"
    headers["References"] = "<post/#{post.id}@sheltered-hollows-76187>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(user, post)

    headers["In-Reply_To"] = "<post/#{post.id}@sheltered-hollows-76187>"
    headers["References"] = "<post/#{post.id}@sheltered-hollows-76187>"

    @user = user
    @post = post


    mail(to: user.email, subject: "You are now following #{post.title}")
  end
end
