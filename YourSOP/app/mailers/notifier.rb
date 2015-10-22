class Notifier < ActionMailer::Base
  default from: 'YourSOP'

  def org_invite(email, pharmacy, inviter, msg)
    @inviter = inviter
    @pharmacy = pharmacy
    @msg = msg
    @email = email
    mail(to: email, subject: 'You have been invited to ' + @pharmacy)
  end

  def do_action(email,doc_name,creator,action)
    @doc_name = doc_name
    @creator = creator
    @action = action
    mail(to: email, subject: 'You got a document action to do')
  end

  def do_audit_action(email,topic_name,creator,action)
    @topic_name = topic_name
    @creator = creator
    @action = action
    mail(to: email, subject: 'You got an audit action to do')
  end

  def assign_role(email,doc_name,creator,role)
    @doc_name = doc_name
    @creator = creator
    @role = role
    mail(to: email, subject: 'You have been assigned a role')
  end

  def assign_audit_role(email,topic_name,creator,role)
    @topic_name = topic_name
    @creator = creator
    @role = role
    mail(to: email, subject: 'You have been assigned a role')
  end

  def doc_status(email,doc_name,outcome)
    @doc_name = doc_name
    @outcome = outcome
    mail(to: email, subject: 'Your document has been updated')
  end

  def audit_status(email,topic_name,outcome)
    @topic_name = topic_name
    @outcome = outcome
    mail(to: email, subject: 'Your audit has been updated')
  end

end
