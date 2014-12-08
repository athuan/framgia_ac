class UsersController < ApplicationController
  def create
    if params[:file].present?
      import_csv("User", params[:file])
      flash[:success] = "User imported!"
    else
      flash[:error] = " User import error!"
    end
    redirect_to root_path
  end

  private
    def import_csv model, file
      CSV.foreach(file.path, headers: true) do |row|
        if model.constantize.where(uid: row[Settings.user.uid]).blank?
          model.constantize.create(display_name: row[Settings.user.display_name], 
            email: row[Settings.user.email], uid: row[Settings.user.uid])
        end
      end
    end
end
