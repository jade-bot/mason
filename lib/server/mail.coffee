nodemailer = require 'nodemailer'

smtpTransport = nodemailer.createTransport 'SMTP',
  service: 'Gmail'
  auth:
    user: 'pyro@feisty.io'
    pass: 'syn3sth3s14'

module.exports = mail = {}

mail.join = (user) ->
  mailOptions =
    from: 'pyro@feisty.io'
    to: user.email
    subject: 'Welcome to the ToE'
    text: "Welcome to the Theory of Everything, #{user.alias}"
    html: "Welcome to the <strong>Theory of Everything</strong>, #{user.alias}"
  
  smtpTransport.sendMail mailOptions, (error, response) ->
    if error then console.log error
    else console.log "Message sent: " + response.message