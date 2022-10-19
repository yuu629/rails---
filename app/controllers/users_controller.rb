class UsersController < ApplicationController
  def index
   @users = User.all#allメソッドはusersテーブルのレコードを全て取得できるメソッド 
  end

# ここより下の各アクションを追加しましょう
  def new
   @user = User.new 
  end

  def create
   @user = User.new(params.require(:user).permit(:name, :email, :age, :introduction))
   if @user.save
     flash[:notice] = "ユーザーを新規登録しました"
     redirect_to :users
   else
    render"new"
   end 
  end

  def show
   @user = User.find(params[:id])
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   if @user.update(params.require(:user).permit(:name, :email, :age, :introduction))
    flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
    redirect_to :users
   else
    render "edit" 
  end  
 end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users, notice: "Task was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
   flash[:notice] = "ユーザーを削除しました"
   redirect_to :users
  end
 end
end