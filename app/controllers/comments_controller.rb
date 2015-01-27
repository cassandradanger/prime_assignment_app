class CommentsController < AdminApplicationController
  def new
    @context = context
    @comment = @context.comments.new
  end

  def create
    @context = context
    @comment = @context.comments.new(comment_params)
    @comment.admin = current_admin
    if @comment.save
      flash[:success] = "Note created successfully!"
      redirect_to context_url(context)
    end
  end

  def edit
    @context = context
    @comment = context.comments.find(params[:id])
    respond_to do |format|
      format.js
      format.json
    end
  end

  def update
    @context = context
    @comment = @context.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      respond_to do |format|
        format.html do
          flash[:success] = "Note updated successfully!"
          redirect_to context_url(context)
        end
        format.js
      end
    end
  end

  def destroy
    @context = context
    @comment = context.comments.find(params[:id])
    @comment.archived = true
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit!
  end

  def context
    if params[:admission_application_id]
      id = params[:admission_application_id]
      AdmissionApplication.find(params[:admission_application_id])
      # else
      #   id = params[:business_id]
      #   Business.find(params[:business_id])
    end
  end

  def context_url(context)
    if AdmissionApplication === context
      admission_application_path(context)
      # else
      #   business_path(context)
    end
  end
end
