module UsersHelper
  def delete_user?(user)
    link_to 'Delete', user_path(user), method: :delete, data: { confirm: 'Really delete this user?' },
                                       class: 'btn btn-secundary'
  end

  def follow_or_stop(user)
    return if user == current_user

    if current_user.follows?(user)
      link_to user_path(@user, params: { follow: 'unfollow' }), method: :post, class: 'no-follow' do
        tag.i class: 'fas fa-plus' do
          tag.svg 'aria-hidden'.to_sym => true, focusable: false, 'data-prefix'.to_sym => 'fas',
                  'data-icon'.to_sym => 'check', class: 'svg-inline--fa fa-check fa-w-16', role: 'img',
                  xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 512 512' do
            tag.path fill: 'currentColor', d: 'M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206
             0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095
              72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997
              26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z'
          end
        end
      end
    else
      link_to user_path(@user, params: { follow: 'follow' }), method: :post, class: 'yes-follow' do
        tag.i class: 'fas fa-check' do
          tag.svg 'aria-hidden'.to_sym => true, focusable: false, 'data-prefix'.to_sym => 'fas',
                  'data-icon'.to_sym => 'plus', class: 'svg-inline--fa fa-plus fa-w-14', role: 'img',
                  xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 448 512' do
            tag.path fill: 'currentColor', d: 'M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67
             0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67
              14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z'
          end
        end
      end
    end
  end

  def profile_pic(user)
    image_tag(user.photo, alt: user.name, class: 'profile-image')
  end
end
