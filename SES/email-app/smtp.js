"use strict";
const nodemailer = require("nodemailer");

async function main() {
  const transporter = nodemailer.createTransport({
    host: "{smtp-server}",
    port: 587,
    auth: {
      user: "{SMTP Username}",
      pass: "{SMTP Password}",
    },
  });

  await transporter.sendMail({
    from: "from_address@example.com",
    to: "to_address@example.com",
    subject: "Test Email SMTP",
    html: "<h1>Hello from Aws SES SMTP</h1>",
  });
}

main().catch(console.error);
