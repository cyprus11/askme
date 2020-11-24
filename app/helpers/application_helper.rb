module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def questions_form_count(q_count)
    q_count %= 100 if q_count > 100
    q_count %= 10 if q_count > 20

    return "#{q_count} вопрос" if q_count == 1
    return "#{q_count} вопроса" if q_count.between?(2, 4)
    "#{q_count} вопросов"
  end
end
