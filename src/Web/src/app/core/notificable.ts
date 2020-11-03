export interface Notifiable {
  send(message: string): void;

  run(): Promise<void>;
}
