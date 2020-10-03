class StaffsController < ApplicationController
  before_action :set_staff, only: [:edit, :update, :destroy]
  
  before_action :require_staff_logged_in, only: [:index, :show]
  before_action :auth_staff , only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @staffs = Staff.order(id: :desc).page(params[:page]).per(5)
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    
    if @staff.save
      flash[:success] = 'スタッフを登録しました。'
      redirect_to staffs_path
    else
      flash.now[:danger] = 'スタッフの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      # 変更された場合のみメッセージ追加
      if @staff.saved_changes?
        flash[:success] = 'スタッフの修正をしました。'
        redirect_to staffs_path
      else
        flash.now[:warning] = '値が変更されていません。'
        render :edit
      end
    else
      flash.now[:danger] = 'スタッフの修正に失敗しました。'
      render :edit
    end
  end

  def destroy
    @staff.destroy
    flash.now[:success] = 'スタッフを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_staff
    @staff = Staff.find(params[:id])
  end
  
  def staff_params
    params.require(:staff).permit(:name, :password, :password_confirmation, :staff_id)
  end
  
  def auth_staff
    if current_staff.auth != 1
      redirect_to root_url
    end
  end
end
