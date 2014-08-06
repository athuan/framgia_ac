class ExcelsController < ApplicationController

  def index
  end

  def import
    if params[:file].present?
      import_xls params[:file]
      flash[:success] = "imported!"
      SentUser.all.delete_all
      User.all.each do |user|
        if File.exists? Settings.excel_files + '/' + user.uid + '.xls'
          sent_user = SentUser.create(uid: user.uid, sent: false, note: params[:file].original_filename)
        end
      end
      redirect_to excels_list_user_path
    else
      flash[:error] = "Chosen file to import!"
      redirect_to root_path
    end
  end

  def list_user
    #@users = User.actives
    @names = load_metadata
  end

  def sent_email
    @uid = params[:uid]
    user = User.find_by(uid: @uid)
    Notifier.delay.sent_mail(user)
    SentUser.find_by(uid: @uid).update_attributes(sent: true)
    respond_to do |format|
      format.html { redirect_to excels_list_user_path }
      format.js
    end
  end

  def sent_all
    User.all.each do |user|
      Notifier.delay.sent_mail(user)
      SentUser.find_by(uid: user.uid).update_attributes(sent: true)
    end
    redirect_to :back
  end

  def download
    uid = params[:uid]
    send_file "app/assets/excels/#{uid}.xls"
    #redirect_to excels_list_user_path
  end

  def finish
    FileUtils.rm_rf(Dir.glob(Settings.excel_files + "/*"))
    redirect_to root_path
  end
end


