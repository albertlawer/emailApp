class QuickmailController < ApplicationController

	def quick_mail
		@sender_email = SenderEmail.where(company_id: current_user.client_id)
		@sender_email = @sender_email.map { |a|[a.name, a.id]  }
		@email_groups = MailGroup.where(company_id: current_user.client_id)
		@email_groups = @email_groups.map { |a|[a.name, a.id]  }
      	@sender_email_id = nil
      	@email_group_id = nil
      	@body = ""
      	@subject = ""
	end


	def quick_create
		@quick_mail = quick_mail_params
		@sender_email = SenderEmail.where(company_id: current_user.client_id)
		@sender_email = @sender_email.map { |a|[a.name, a.id]  }
		@email_groups = MailGroup.where(company_id: current_user.client_id)
		@email_groups = @email_groups.map { |a|[a.name, a.id]  }
		@sender_email_id = quick_mail_params[:sender_email_id]
      	@email_group_id = quick_mail_params[:email_group_id]
      	@body = quick_mail_params[:body]
      	@subject = quick_mail_params[:subject]
      	@the_resp = SenderEmail.send_quick_mail(@quick_mail)

		respond_to do |format|
			if @the_resp == 1
				format.html { redirect_to root_path, notice: 'Quick mail was successfully created. Open Email Transactions to view status.' }
			elsif @the_resp == 2
				format.html { redirect_to root_path, alert: 'Sorry! Your package has expired, please renew your package.' }
			elsif @the_resp == 3
				format.html { redirect_to quick_mail_path, alert: 'Please fill in the sender email, recipient group, the subject and the body to continue.' }
			end
		end
	end



  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def quick_mail_params
      params.require(:quick_mail).permit(:sender_email_id, :email_group_id, :body, :subject, :company_id, :user_id)
    end
end
