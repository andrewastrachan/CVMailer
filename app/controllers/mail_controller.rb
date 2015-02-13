class MailController < ApplicationController
  def new
    
  end
  
  def create
    current_user.jobs.each do |job|
      next if job.sent == true
      @job = job
      @user = current_user
      resume = File.read(current_user.resume.current_path)
      pdf = render_to_string(:pdf => 'cover_letter',:template => 'jobs/show.pdf.erb')
      UserMailer.email_blast(job, pdf, resume, {user_name: params[:gmail][:user_name], password: params[:gmail][:password]}).deliver_now
      job.send_job
    end
    redirect_to jobs_url
  end
end
