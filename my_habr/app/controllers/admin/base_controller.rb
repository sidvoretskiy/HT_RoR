class Admin::BaseController < ApplicationController
  layout('admin')
  before_action :authenticate_user!
  before_action :user_admin_check

  protected

  def user_admin_check
    unless current_user.admin?
      redirect_to root_path,
                  alert: 'У вас нет прав на просмотр этой страницы'
    end
  end


end