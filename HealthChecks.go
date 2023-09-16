package main

import (
	"fmt"
	"log"
	"net/smtp"
	"os"
	"os/exec"
)

func main() {
	// Perform health checks
	if err := performHealthChecks(); err != nil {
		// Send an email notification
		subject := "Server Health Check Failed"
		message := "One or more health checks have failed on the server. Please investigate."
		recipient := "email@example.com"
		smtpServer := "smtp.example.com"
		smtpPort := "587"
		smtpUsername := "smtp.username"
		smtpPassword := "smtp.password"

		if err := sendEmail(subject, message, recipient, smtpServer, smtpPort, smtpUsername, smtpPassword); err != nil {
			log.Printf("Failed to send email notification: %v", err)
		}

		// Exit with an error code
		os.Exit(1)
	}

	fmt.Println("Server health is OK")
}

func performHealthChecks() error {
	// Add your health checks here
	// Example: Check disk space
	cmd := exec.Command("df", "-h", "/")
	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("Error checking disk space: %v", err)
	}

	fmt.Println("Disk Space Check:")
	fmt.Println(string(output))

	// Add more health checks as needed...

	return nil
}

func sendEmail(subject, message, recipient, smtpServer, smtpPort, smtpUsername, smtpPassword string) error {
	auth := smtp.PlainAuth("", smtpUsername, smtpPassword, smtpServer)

	msg := []byte("Subject: " + subject + "\r\n" +
		"From: " + smtpUsername + "\r\n" +
		"To: " + recipient + "\r\n" +
		"\r\n" +
		message + "\r\n")

	err := smtp.SendMail(smtpServer+":"+smtpPort, auth, smtpUsername, []string{recipient}, msg)
	if err != nil {
		return fmt.Errorf("Error sending email: %v", err)
	}

	fmt.Println("Email notification sent successfully")
	return nil
}

