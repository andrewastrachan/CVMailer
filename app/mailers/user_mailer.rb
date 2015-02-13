class UserMailer < ApplicationMailer
  default from: "andrewastrachan92@gmail.com"
  
  def email_blast(job, pdf, mail_params)
    @greeting = job.process_greeting
    @blurb = job.blurb
    title = job.process_title
    attachments['MyPDF.pdf'] = pdf
    mail to: job.email, 
         bcc: ["andrewastrachan92@gmail.com"],
         subject: title, 
         delivery_method_options: mail_params
  end
end
