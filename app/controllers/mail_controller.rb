class MailController < ApplicationController
  def new
    
  end
  
  def create
    current_user.jobs.each do |job|
      next if job.sent == true
      @job = job
      @user = current_user
      pdf = render_to_string(:pdf => 'MyPDF',:template => 'jobs/show.pdf.erb')
      UserMailer.email_blast(job, pdf, {user_name: params[:gmail][:user_name], password: params[:gmail][:password]}).deliver_now
      job.send_job
    end
    redirect_to jobs_url
  end
end
