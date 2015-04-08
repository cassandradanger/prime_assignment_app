class AdminsController < AdminApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :edit_password, :update_password]
  respond_to :html

  def index
    @admins = Admin.all
  end

  def show
  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      flash[:success] = "Employee updated successfully!"
      redirect_to(admins_path)
    else
      render :edit
    end
  end

  def edit_password
  end

  def update_password
    if @admin.update(admin_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @admin, :bypass => true
      redirect_to admins_path
    else
      render :edit_password
    end
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "Employee created successfully!"
      redirect_to admins_path
    else
      render :new
    end
  end

  private
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :status, :password, :password_confirmation)
  end
end