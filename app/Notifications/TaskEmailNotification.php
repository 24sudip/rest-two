<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class TaskEmailNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public $user, $task, $message;

    /**
     * Create a new notification instance.
     */
    public function __construct($user, $task, $message)
    {
        $this->user = $user;
        $this->task = $task;
        $this->message = $message;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
                    ->line($this->message . ' - ' . $this->task->title . ' created by ' . $this->user->name . ' for you!')
                    ->action('Open Task Track', url('http://127.0.0.1:8000/'))
                    ->line('Thank you for using Task Tracking!');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
