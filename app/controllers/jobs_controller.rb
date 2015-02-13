class JobsController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :all_jobs, only: [:index, :destroy]
  respond_to :html, :js
  
  def new
    @job = Job.new
  end
  
  def create
    @job = current_user.jobs.new(job_params)
    @job.save!
  end
  
  def show
    @user = current_user
    @job = Job.find(params[:id])
    respond_to do |format|
      format.pdf do 
        render :pdf => "jobs/show.pdf.erb"
      end
    end
  end
  
  def destroy
    job = Job.find(params[:id])
    job.destroy
  end
  
  def import
    Job.import(params[:file], current_user)
    flash[:success] = "Jobs Imported"
    redirect_to jobs_url
  end
  
  protected
  
  def all_jobs
    @jobs = current_user.jobs
  end
  
  def job_params
    params.require(:job).permit(:company, :recipient, :address, :blurb, :email,)
  end
end
